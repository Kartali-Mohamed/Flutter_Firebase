import 'package:flutter/material.dart';

class CustomTitlePage extends StatelessWidget {
  final String title;
  const CustomTitlePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
  }
}
