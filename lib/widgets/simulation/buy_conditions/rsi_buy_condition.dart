import 'package:flutter/material.dart';

import '../widgets/text_button.dart';

class RsiBuyCondition extends StatelessWidget {
  final Map conditions;
  final Function changeCondition;

  RsiBuyCondition(this.conditions, this.changeCondition);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              "Bugün RSI",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  "<",
                  changeCondition,
                  conditions["first_compare"],
                  "first_compare",
                  "rsi",
                ),
                TextButton(
                  ">",
                  changeCondition,
                  conditions["first_compare"],
                  "first_compare",
                  "rsi",
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Bir gün önce RSI",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  "<",
                  changeCondition,
                  conditions["second_compare"],
                  "second_compare",
                  "rsi",
                ),
                TextButton(
                  ">",
                  changeCondition,
                  conditions["second_compare"],
                  "second_compare",
                  "rsi",
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            child: Text(
              "İki gün önce RSI",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  "<",
                  changeCondition,
                  conditions["third_compare"],
                  "third_compare",
                  "rsi",
                ),
                TextButton(
                  ">",
                  changeCondition,
                  conditions["third_compare"],
                  "third_compare",
                  "rsi",
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Üç gün önce RSI",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Bugün RSI  ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                TextButton(
                  "<",
                  changeCondition,
                  conditions["rsi_compare"],
                  "rsi_compare",
                  "rsi",
                ),
                TextButton(
                  ">",
                  changeCondition,
                  conditions["rsi_compare"],
                  "rsi_compare",
                  "rsi",
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "  ${conditions["rsi_value"].round()}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: conditions["rsi_value"].toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: '${conditions["rsi_value"].round()}',
                    onChanged: (double newValue) {
                      changeCondition("rsi", "rsi_value", newValue);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
