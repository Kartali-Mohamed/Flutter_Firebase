import 'package:flutter/material.dart';

class CustomSubtitlePage extends StatelessWidget {
  final String subtitle;
  const CustomSubtitlePage({Key? key, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(subtitle, style: const TextStyle(color: Colors.grey));
  }
}
