import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  SendButton({this.text, this.callback});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.orange,
      onPressed: callback,
      child: Text(text),
    );
  }
}
