import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:message_app/views/chat_view.dart';
import 'package:message_app/views/login_view.dart';
import 'package:message_app/views/register_view.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MessageApp());
}

class MessageApp extends StatelessWidget {
  const MessageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RegisterView.id: (context) => RegisterView(),
        LogIn.id: (context) => LogIn(),
        ChatView.id: (contex) => ChatView()
      },
      initialRoute: LogIn.id,
      debugShowCheckedModeBanner: false,
      home: LogIn(),
    );
  }
}
