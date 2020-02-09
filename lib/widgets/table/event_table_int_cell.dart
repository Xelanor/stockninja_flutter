import 'package:flutter/material.dart';

class EventTableIntCell extends StatelessWidget {
  final String text;

  EventTableIntCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      height: 40,
      alignment: Alignment.center,
    );
  }
}
