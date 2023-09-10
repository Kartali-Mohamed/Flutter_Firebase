import 'package:flutter/material.dart';

class CustomForgotPassword extends StatelessWidget {
  final void Function()? onTap;
  const CustomForgotPassword({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 20),
        alignment: Alignment.topRight,
        child: const Text(
          "Forgot Password ?",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
