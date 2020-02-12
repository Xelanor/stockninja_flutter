import 'package:flutter/material.dart';

class StockTableTitleCell extends StatelessWidget {
  final String text;
  final String shortName;

  StockTableTitleCell(this.text, this.shortName);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16),
      color: Theme.of(context).colorScheme.onPrimary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FittedBox(
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            shortName,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 10,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      height: 50,
    );
  }
}
