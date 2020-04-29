import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget {
  final int number;
  final Function changeNumber;
  final int currentNumber;
  final String conditionName;
  final String category;

  NumberButton(
    this.number,
    this.changeNumber,
    this.currentNumber,
    this.conditionName,
    this.category,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (this.currentNumber == number) {
          changeNumber(category, conditionName, 0);
        } else {
          changeNumber(category, conditionName, number);
        }
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          border: Border.all(
            color: number == currentNumber
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[700],
          ),
          color: number == currentNumber
              ? Theme.of(context).colorScheme.primaryVariant
              : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: Text(
          '$number',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
