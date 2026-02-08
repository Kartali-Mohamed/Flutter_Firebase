import 'package:flutter/material.dart';

class CustomSubtitlePage extends StatelessWidget {
  final String subtitle;
  const CustomSubtitlePage({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Text(subtitle, style: const TextStyle(color: Colors.grey));
  }
}
