import 'package:flutter/material.dart';

class HomeCardFolder extends StatelessWidget {
  final String title;
  final void Function()? onLongPress;
  const HomeCardFolder({Key? key, required this.title, this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/images/folder.png",
              height: 80,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
