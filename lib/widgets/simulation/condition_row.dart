import 'package:flutter/material.dart';

import '../simulation/buy_conditions/price_buy_condition.dart';
import '../simulation/buy_conditions/triple_buy_condition.dart';
import '../simulation/buy_conditions/rsi_buy_condition.dart';
import '../simulation/buy_conditions/trace_sell_condition.dart';
import '../simulation/buy_conditions/aroon_buy_condition.dart';
import '../simulation/buy_conditions/after_sell_condition.dart';

class ConditionRow extends StatelessWidget {
  final String conditionName;
  final bool checked;
  final bool expanded;
  final String condition;
  final Function expandCondition;
  final Function checkCondition;
  final Map conditions;
  final Function changeCondition;

  ConditionRow(
    this.conditionName,
    this.checked,
    this.expanded,
    this.condition,
    this.expandCondition,
    this.checkCondition,
    this.conditions,
    this.changeCondition,
  );

  Widget conditionRender(condition) {
    switch (condition) {
      case "price":
        {
          return PriceBuyCondition(conditions, changeCondition);
        }
        break;
      case "triple":
        {
          return TripleBuyCondition(conditions, changeCondition);
        }
        break;
      case "rsi":
        {
          return RsiBuyCondition(conditions, changeCondition);
        }
        break;
      case "trace":
        {
          return TraceSellCondition(conditions, changeCondition);
        }
        break;
      case "aroon":
        {
          return AroonBuyCondition(conditions, changeCondition);
        }
        break;
      case "after_sell":
        {
          return AfterSellCondition(conditions, changeCondition);
        }
        break;
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Checkbox(
                      onChanged: (bool newValue) => checkCondition(
                        condition,
                        newValue,
                      ),
                      value: checked,
                      checkColor: Theme.of(context).colorScheme.primary,
                    ),
                    Container(
                      child: Text(
                        conditionName,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: IconButton(
                    onPressed: () => expandCondition(condition),
                    icon: Icon(
                      expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
          expanded
              ? Container(
                  child: conditionRender(condition),
                )
              : Container()
        ],
      ),
    );
  }
}
