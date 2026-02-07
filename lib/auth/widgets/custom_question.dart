import 'package:flutter/material.dart';

class CustomQuestion extends StatelessWidget {
  final String question;
  final String answer;
  final void Function()? onTap;
  const CustomQuestion(
      {super.key,
      required this.question,
      required this.answer,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Text.rich(TextSpan(children: [
          TextSpan(
            text: question,
          ),
          TextSpan(
              text: answer,
              style: const TextStyle(
                  color: Colors.orange, fontWeight: FontWeight.bold)),
        ])),
      ),
    );
  }
}
