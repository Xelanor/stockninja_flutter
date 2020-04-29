import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {
  final String text;
  final Function changeText;
  final String currentText;
  final String conditionName;
  final String category;

  TextButton(
    this.text,
    this.changeText,
    this.currentText,
    this.conditionName,
    this.category,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (this.currentText == text) {
          changeText(category, conditionName, "");
        } else {
          changeText(category, conditionName, text);
        }
      },
      child: Container(
        // width: 150,
        // height: 60,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: text == currentText
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[700],
          ),
          color: text == currentText
              ? Theme.of(context).colorScheme.primaryVariant
              : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: Text(
          '$text',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
