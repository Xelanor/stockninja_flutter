import 'package:flutter/material.dart';

class IndicatorTableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(0, 11, 19, 1),
      height: 20,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: Text(
                "",
                style: TextStyle(color: Colors.white60),
              ),
              height: 30,
              alignment: Alignment.center,
            ),
            flex: 25,
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: Text(
                "RSI",
                style: TextStyle(color: Colors.white60),
              ),
              height: 30,
              alignment: Alignment.center,
            ),
            flex: 20,
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: Text(
                "NINJA",
                style: TextStyle(color: Colors.white60),
              ),
              height: 30,
              alignment: Alignment.center,
            ),
            flex: 20,
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: FittedBox(
                child: Text(
                  "F/K",
                  style: TextStyle(color: Colors.white60),
                ),
              ),
              height: 30,
              alignment: Alignment.center,
            ),
            flex: 20,
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: Text(
                "PD/DD",
                style: TextStyle(color: Colors.white60),
              ),
              height: 30,
              alignment: Alignment.center,
            ),
            flex: 20,
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: Text(
                "ÖZ.V.KR",
                style: TextStyle(color: Colors.white60),
              ),
              height: 30,
              alignment: Alignment.center,
            ),
            flex: 20,
          ),
        ],
      ),
    );
  }
}
