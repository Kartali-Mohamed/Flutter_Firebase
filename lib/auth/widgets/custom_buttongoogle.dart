import 'package:flutter/material.dart';

class CustomButtonGoogle extends StatelessWidget {
  final void Function()? onPressed;
  const CustomButtonGoogle({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: 40,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFFD32F2F))),
        color: Colors.white,
        textColor: Colors.red[700],
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Login With Google  "),
            Image.asset(
              "assets/images/google_logo.png",
              width: 20,
            )
          ],
        ));
  }
}
