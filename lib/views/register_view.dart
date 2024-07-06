import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message_app/consts.dart';
import 'package:message_app/views/chat_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widget/button_to_creat_account.dart';
import '../widget/button_widget_register.dart';
import '../widget/text_field_widget.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  static String id = 'Register';
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kprimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 90,
                ),
                Image.asset(
                  kLogo,
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Abdullah Chat',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 90,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  onchange: (data) {
                    email = data;
                  },
                  hintText: 'email',
                ),
                SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  onchange: (data) {
                    password = data;
                  },
                  hintText: 'password',
                ),
                SizedBox(height: 20),
                ButtonWidget(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        isLoading = true;
                        await registerUser();
                        Navigator.pushNamed(context, ChatView.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(
                              context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context,
                              'Wrong password provided for that user.');
                        }
                      } catch (e) {
                        showSnackBar(context, 'therr was an error');
                      }
                      isLoading = false;
                    }
                  },
                  text: 'Register',
                ),
                SizedBox(height: 20),
                ButtonToCeratAccount(
                    title: 'already have an account',
                    textCreat: 'Login',
                    ontap: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    
    );
  }
}
