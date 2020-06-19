import 'package:flutter/material.dart';

class TraceSellCondition extends StatelessWidget {
  final Map conditions;
  final Function changeCondition;

  TraceSellCondition(this.conditions, this.changeCondition);

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
                    "% ${conditions["value"]}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: conditions["value"].toDouble(),
                    min: 0,
                    max: 5,
                    divisions: 10,
                    label: '%${conditions["value"]}',
                    onChanged: (double newValue) {
                      changeCondition("trace", "value", newValue);
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
