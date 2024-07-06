import 'package:message_app/consts.dart';

class Message {
  final String message;
  final String id;

  Message(this.message, this.id);

  factory Message.fromDocument(doc) {
    return Message(
      doc.data()[kMessage],
      doc.data()['id'] ?? '',
    );
  }
}
