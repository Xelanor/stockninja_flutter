import 'package:flutter/material.dart';

class StockTableStrCell extends StatelessWidget {
  final String text;

  StockTableStrCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onPrimary,
      child: FittedBox(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      height: 50,
      alignment: Alignment.center,
    );
  }
}
