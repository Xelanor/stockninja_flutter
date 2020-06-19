import 'package:flutter/material.dart';

import '../widgets/single_slider.dart';
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
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Fiyat: ${conditions["price"].round()}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: conditions["price"].toDouble(),
                    min: 1,
                    max: 4,
                    divisions: 3,
                    label: '${conditions["price"].round()}',
                    onChanged: (double newValue) {
                      changeCondition("triple", "price", newValue);
                    },
                  ),
                ),
                TextButton(
                  "<",
                  changeCondition,
                  conditions["price_compare"],
                  "price_compare",
                  "triple",
                ),
                TextButton(
                  ">",
                  changeCondition,
                  conditions["price_compare"],
                  "price_compare",
                  "triple",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Kısa: ${conditions["short_value"].round()}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: conditions["short_value"].toDouble(),
                    min: 1,
                    max: 4,
                    divisions: 3,
                    label: '${conditions["short_value"].round()}',
                    onChanged: (double newValue) {
                      changeCondition("triple", "short_value", newValue);
                    },
                  ),
                ),
                TextButton(
                  "<",
                  changeCondition,
                  conditions["short_compare"],
                  "short_compare",
                  "triple",
                ),
                TextButton(
                  ">",
                  changeCondition,
                  conditions["short_compare"],
                  "short_compare",
                  "triple",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Orta: ${conditions["medium_value"].round()}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: conditions["medium_value"].toDouble(),
                    min: 1,
                    max: 4,
                    divisions: 3,
                    label: '${conditions["medium_value"].round()}',
                    onChanged: (double newValue) {
                      changeCondition("triple", "medium_value", newValue);
                    },
                  ),
                ),
                TextButton(
                  "<",
                  changeCondition,
                  conditions["medium_compare"],
                  "medium_compare",
                  "triple",
                ),
                TextButton(
                  ">",
                  changeCondition,
                  conditions["medium_compare"],
                  "medium_compare",
                  "triple",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Uzun: ${conditions["long_value"].round()}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: conditions["long_value"].toDouble(),
                    min: 1,
                    max: 4,
                    divisions: 3,
                    label: '${conditions["long_value"].round()}',
                    onChanged: (double newValue) {
                      changeCondition("triple", "long_value", newValue);
                    },
                  ),
                ),
                TextButton(
                  "<",
                  changeCondition,
                  conditions["long_compare"],
                  "long_compare",
                  "triple",
                ),
                TextButton(
                  ">",
                  changeCondition,
                  conditions["long_compare"],
                  "long_compare",
                  "triple",
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 20,
            thickness: 5,
          ),
          SingleSlider(
            conditions,
            changeCondition,
            "Kısa",
            5,
            9,
            6,
            "triple",
            "short",
          ),
          SingleSlider(
            conditions,
            changeCondition,
            "Orta",
            10,
            21,
            11,
            "triple",
            "medium",
          ),
          SingleSlider(
            conditions,
            changeCondition,
            "Uzun",
            21,
            30,
            9,
            "triple",
            "long",
          ),
        ],
      ),
    );
  }
}
