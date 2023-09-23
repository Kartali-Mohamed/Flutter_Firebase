import 'package:flutter/material.dart';

class CustomNoteImageButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool isSelected;
  const CustomNoteImageButton(
      {super.key, required this.onPressed, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: isSelected ? Colors.green : Colors.orange,
      textColor: Colors.white,
      onPressed: onPressed,
      child: const Text("Upload image"),
    );
  }
}
