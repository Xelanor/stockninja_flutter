import 'package:flutter/material.dart';

import '../widgets/number_button.dart';
import '../widgets/text_button.dart';

class PriceBuyCondition extends StatelessWidget {
  final Map conditions;
  final Function changeCondition;

  PriceBuyCondition(this.conditions, this.changeCondition);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              NumberButton(
                1,
                changeCondition,
                conditions["priceDay"],
                "priceDay",
                "price",
              ),
              NumberButton(
                2,
                changeCondition,
                conditions["priceDay"],
                "priceDay",
                "price",
              ),
              NumberButton(
                3,
                changeCondition,
                conditions["priceDay"],
                "priceDay",
                "price",
              ),
              NumberButton(
                4,
                changeCondition,
                conditions["priceDay"],
                "priceDay",
                "price",
              ),
              NumberButton(
                5,
                changeCondition,
                conditions["priceDay"],
                "priceDay",
                "price",
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: Text(
              "gün öncesine göre",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "% ${conditions["pricePercentage"]}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: conditions["pricePercentage"].toDouble(),
                    min: -5,
                    max: 5,
                    divisions: 20,
                    label: '%${conditions["pricePercentage"]}',
                    onChanged: (double newValue) {
                      changeCondition("price", "pricePercentage", newValue);
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                "Düşük",
                changeCondition,
                conditions["priceCondition"],
                "priceCondition",
                "price",
              ),
              TextButton(
                "Sıralı Düşük",
                changeCondition,
                conditions["priceCondition"],
                "priceCondition",
                "price",
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                "Yüksek",
                changeCondition,
                conditions["priceCondition"],
                "priceCondition",
                "price",
              ),
              TextButton(
                "Sıralı Yüksek",
                changeCondition,
                conditions["priceCondition"],
                "priceCondition",
                "price",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
