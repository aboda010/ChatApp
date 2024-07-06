import 'package:flutter/material.dart';

class ButtonToCeratAccount extends StatelessWidget {
  const ButtonToCeratAccount(
      {super.key,
      required this.title,
      required this.textCreat,
      required this.ontap});
  final String title;
  final String textCreat;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 14),
        GestureDetector(
          onTap: ontap,
          child: Container(
              child: Text(
            textCreat,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          )),
        )
      ],
    );
  }
}
