import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:message_app/consts.dart';
import 'package:message_app/views/chat_view.dart';
import 'package:message_app/views/register_view.dart';

import '../widget/button_to_creat_account.dart';
import '../widget/button_widget_register.dart';
import '../widget/text_field_widget.dart';

class LogIn extends StatefulWidget {
  LogIn({super.key});
  static String id = 'Login';

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Center(
                child: Text(
                  'Abdullah Chat',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 90,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign In',
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
                obsecurText: true,
                onchange: (data) {
                  password = data;
                },
                hintText: 'password',
              ),
              SizedBox(height: 30),
              ButtonWidget(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      isLoading = true;
                      setState(() {});
                      await sigInUser();
                      Navigator.pushNamed(context, ChatView.id,
                          arguments: email);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'wrong-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('wrong password'),
                          ),
                        );
                      } else if (e.code == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('email already in use'),
                          ),
                        );
                      }
                    } catch (e) {}

                    setState(() {});
                  }
                  isLoading = false;
                },
                text: 'Sign In',
              ),
              SizedBox(height: 15),
              ButtonToCeratAccount(
                ontap: () {
                  Navigator.pushNamed(context, RegisterView.id);
                },
                title: 'Creat account',
                textCreat: 'Register',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sigInUser() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
