import 'package:flutter/material.dart';

import '../widgets/text_button.dart';

class AroonBuyCondition extends StatelessWidget {
  final Map conditions;
  final Function changeCondition;

  AroonBuyCondition(this.conditions, this.changeCondition);

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
                    "Up:       ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: RangeSlider(
                    values: RangeValues(
                      conditions["up_lower"].toDouble(),
                      conditions["up_upper"].toDouble(),
                    ),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    labels: RangeLabels(
                      '${conditions["up_lower"].round()}',
                      '${conditions["up_upper"].round()}',
                    ),
                    onChanged: (RangeValues newRange) {
                      changeCondition("aroon", "up_lower", newRange.start);
                      changeCondition("aroon", "up_upper", newRange.end);
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
                    "Down: ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: RangeSlider(
                    values: RangeValues(
                      conditions["down_lower"].toDouble(),
                      conditions["down_upper"].toDouble(),
                    ),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    labels: RangeLabels(
                      '${conditions["down_lower"].round()}',
                      '${conditions["down_upper"].round()}',
                    ),
                    onChanged: (RangeValues newRange) {
                      changeCondition("aroon", "down_lower", newRange.start);
                      changeCondition("aroon", "down_upper", newRange.end);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                "VE",
                changeCondition,
                conditions["aroon_compare"],
                "aroon_compare",
                "aroon",
              ),
              TextButton(
                "VEYA",
                changeCondition,
                conditions["aroon_compare"],
                "aroon_compare",
                "aroon",
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Uptrend: ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                TextButton(
                  "↓",
                  changeCondition,
                  conditions["uptrend"],
                  "uptrend",
                  "aroon",
                ),
                TextButton(
                  "↑",
                  changeCondition,
                  conditions["uptrend"],
                  "uptrend",
                  "aroon",
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Downtrend: ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                TextButton(
                  "↓",
                  changeCondition,
                  conditions["downtrend"],
                  "downtrend",
                  "aroon",
                ),
                TextButton(
                  "↑",
                  changeCondition,
                  conditions["downtrend"],
                  "downtrend",
                  "aroon",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
