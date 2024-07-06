import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {super.key,
      required this.hintText,
      this.onchange,
      this.obsecurText = false});
  final String hintText;
  final Function(String)? onchange;
  bool? obsecurText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecurText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'there was an error in data!';
        }
      },
      onChanged: onchange,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
    );
  }
}
