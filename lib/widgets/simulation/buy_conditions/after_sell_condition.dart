import 'package:flutter/material.dart';

import '../widgets/text_button.dart';

class AfterSellCondition extends StatelessWidget {
  final Map conditions;
  final Function changeCondition;

  AfterSellCondition(this.conditions, this.changeCondition);

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
                    "%: ${conditions["percent"].round()}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: conditions["percent"].toDouble(),
                    min: 0,
                    max: 5,
                    divisions: 5,
                    label: '${conditions["percent"].round()}',
                    onChanged: (double newValue) {
                      changeCondition("after_sell", "percent", newValue);
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
                    "Süre: ${conditions["period"].round()}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: conditions["period"].toDouble(),
                    min: 0,
                    max: 5,
                    divisions: 5,
                    label: '${conditions["period"].round()}',
                    onChanged: (double newValue) {
                      changeCondition("after_sell", "period", newValue);
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
