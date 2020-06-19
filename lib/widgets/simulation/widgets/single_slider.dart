import 'package:flutter/material.dart';

class SingleSlider extends StatelessWidget {
  final Map conditions;
  final Function changeCondition;
  final String title;
  final double min;
  final double max;
  final int division;
  final String conditionName;
  final String conditionSetting;

  SingleSlider(
    this.conditions,
    this.changeCondition,
    this.title,
    this.min,
    this.max,
    this.division,
    this.conditionName,
    this.conditionSetting,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              "$title: ${conditions[conditionSetting].round()}",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: Slider(
              value: conditions[conditionSetting].toDouble(),
              min: min,
              max: max,
              divisions: division,
              label: '${conditions[conditionSetting].round()}',
              onChanged: (double newValue) {
                changeCondition(conditionName, conditionSetting, newValue);
              },
            ),
          ),
        ],
      ),
    );
  }
}
