import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final void Function()? onDelete;
  final void Function()? onUpdate;
  const CustomAlertDialog(
      {super.key, required this.onDelete, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Category Options"),
      content: const Text("What do you want?"),
      actions: [
        TextButton(
          onPressed: onDelete,
          child: const Text('Delete'),
        ),
        TextButton(
          onPressed: onUpdate,
          child: const Text('Update'),
        )
      ],
    );
  }
}
