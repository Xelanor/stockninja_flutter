import 'package:flutter/material.dart';

class StockTableHeader extends StatelessWidget {
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
            flex: 25,
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: Text(
                "Fiyat",
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
                "Düşük - Yüksek",
                style: TextStyle(color: Colors.white60),
              ),
              height: 30,
              alignment: Alignment.center,
            ),
            flex: 35,
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: Text(
                "Fark",
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
