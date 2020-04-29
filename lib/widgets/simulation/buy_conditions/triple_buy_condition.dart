import 'package:flutter/material.dart';

import '../widgets/text_button.dart';

class TripleBuyCondition extends StatelessWidget {
  final Map conditions;
  final Function changeCondition;

  TripleBuyCondition(this.conditions, this.changeCondition);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Kısa: ${conditions["short"].round()}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: conditions["short"].toDouble(),
                    min: 7,
                    max: 15,
                    divisions: 8,
                    label: '${conditions["short"].round()}',
                    onChanged: (double newValue) {
                      changeCondition("triple", "short", newValue);
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Uzun: ${conditions["long"].round()}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: conditions["long"].toDouble(),
                    min: 21,
                    max: 30,
                    divisions: 9,
                    label: '${conditions["long"].round()}',
                    onChanged: (double newValue) {
                      changeCondition("triple", "long", newValue);
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  TextButton(
                    "F",
                    changeCondition,
                    conditions["first"],
                    "first",
                    "triple",
                  ),
                  TextButton(
                    "K",
                    changeCondition,
                    conditions["first"],
                    "first",
                    "triple",
                  ),
                  TextButton(
                    "U",
                    changeCondition,
                    conditions["first"],
                    "first",
                    "triple",
                  ),
                  Text(
                    "A",
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  TextButton(
                    "<",
                    changeCondition,
                    conditions["first_compare"],
                    "first_compare",
                    "triple",
                  ),
                  TextButton(
                    ">",
                    changeCondition,
                    conditions["first_compare"],
                    "first_compare",
                    "triple",
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  TextButton(
                    "F",
                    changeCondition,
                    conditions["second"],
                    "second",
                    "triple",
                  ),
                  TextButton(
                    "K",
                    changeCondition,
                    conditions["second"],
                    "second",
                    "triple",
                  ),
                  TextButton(
                    "U",
                    changeCondition,
                    conditions["second"],
                    "second",
                    "triple",
                  ),
                  Text(
                    "B",
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  TextButton(
                    "<",
                    changeCondition,
                    conditions["second_compare"],
                    "second_compare",
                    "triple",
                  ),
                  TextButton(
                    ">",
                    changeCondition,
                    conditions["second_compare"],
                    "second_compare",
                    "triple",
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  TextButton(
                    "F",
                    changeCondition,
                    conditions["third"],
                    "third",
                    "triple",
                  ),
                  TextButton(
                    "K",
                    changeCondition,
                    conditions["third"],
                    "third",
                    "triple",
                  ),
                  TextButton(
                    "U",
                    changeCondition,
                    conditions["third"],
                    "third",
                    "triple",
                  ),
                  Text(
                    "C",
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: conditions["first_percentage"].toDouble(),
                    min: -5,
                    max: 5,
                    divisions: 20,
                    label: '%${conditions["first_percentage"]}',
                    onChanged: (double newValue) {
                      changeCondition("triple", "first_percentage", newValue);
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "B %${conditions["first_percentage"]}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "B",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: conditions["second_percentage"].toDouble(),
                    min: -5,
                    max: 5,
                    divisions: 20,
                    label: '%${conditions["second_percentage"]}',
                    onChanged: (double newValue) {
                      changeCondition("triple", "second_percentage", newValue);
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "C %${conditions["second_percentage"]}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: <Widget>[
          //     TextButton(
          //       "Düşük",
          //       changeCondition,
          //       conditions["priceCondition"],
          //       "priceCondition",
          //       "price",
          //     ),
          //     TextButton(
          //       "Sıralı Düşük",
          //       changeCondition,
          //       conditions["priceCondition"],
          //       "priceCondition",
          //       "price",
          //     ),
          //   ],
          // ),
          // SizedBox(height: 10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: <Widget>[
          //     TextButton(
          //       "Yüksek",
          //       changeCondition,
          //       conditions["priceCondition"],
          //       "priceCondition",
          //       "price",
          //     ),
          //     TextButton(
          //       "Sıralı Yüksek",
          //       changeCondition,
          //       conditions["priceCondition"],
          //       "priceCondition",
          //       "price",
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
