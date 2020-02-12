import 'package:flutter/material.dart';

class StockTableIntCell extends StatelessWidget {
  final String text;
  final bool increasing;

  StockTableIntCell(this.text, this.increasing);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: increasing
              ? Theme.of(context).colorScheme.onSecondary
              : Theme.of(context).colorScheme.error,
        ),
      ),
      height: 50,
      alignment: Alignment.center,
    );
  }
}
