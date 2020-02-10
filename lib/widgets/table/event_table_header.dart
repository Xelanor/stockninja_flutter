import 'package:flutter/material.dart';

class EventTableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(0, 11, 19, 1),
      height: 30,
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
            flex: 30,
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: Text(
                "Azalan",
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
                "Artan",
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
                  "Değişmeyen",
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
                "BIST",
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
