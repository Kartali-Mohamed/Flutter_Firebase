import 'package:flutter/material.dart';

class CustomAddButtonCategory extends StatelessWidget {
  final void Function()? onPressed;
  const CustomAddButtonCategory({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.orange,
      textColor: Colors.white,
      onPressed: onPressed,
      child: const Text("Add category"),
    );
  }
}
