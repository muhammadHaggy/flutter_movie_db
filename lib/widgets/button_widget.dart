import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            onPrimary: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 20),
          ),
          onPressed: onClicked,
        ),
      );
}
