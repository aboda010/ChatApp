import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:message_app/consts.dart';
import 'package:message_app/model/massages.dart';

import '../widget/custem_chat_widget.dart';

class ChatView extends StatelessWidget {
  ChatView({
    super.key,
  });
  final scrollController = ScrollController();
  static String id = 'ChatView';

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageColliction);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromDocument(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kprimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 50,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(fontSize: 25),
                    )
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index] == id
                            ? ChatBuble(
                                message: messagesList[index],
                              )
                            : ChatBubleForFrind(message: messagesList[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add(
                          {
                            kMessage: data,
                            kCreatedAt: DateTime.now(),
                            'id': email,
                          },
                        );
                        controller.clear();

                        scrollController.animateTo(0,
                            duration: Duration(seconds: 3),
                            curve: Curves.fastOutSlowIn);
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Messages',
                        suffix: Icon(
                          Icons.send,
                          color: kprimaryColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kprimaryColor)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  )
                ],
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: kprimaryColor,
              body: Center(
                  child: Text(
                'is Loading....',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              )),
            );
          }
        });
  }
}
