import 'package:flutter/material.dart';

class CustomButtonCategory extends StatelessWidget {
  final void Function()? onPressed;
  final String type;
  const CustomButtonCategory(
      {super.key, required this.onPressed, required this.type});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.orange,
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text("$type category"),
    );
  }
}
