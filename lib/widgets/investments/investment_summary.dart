import 'package:flutter/material.dart';

class InvestmentSummary extends StatelessWidget {
  final String totalEquity;
  final String potentialProfitLoss;

  InvestmentSummary(this.totalEquity, this.potentialProfitLoss);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Toplam Malvarlık',
                  style: TextStyle(fontSize: 16, color: Colors.white60),
                ),
                Text(
                  'TL $totalEquity',
                  style: TextStyle(
                    fontSize: 32,
                    color: double.parse(potentialProfitLoss) >= 0
                        ? Theme.of(context).colorScheme.onSecondary
                        : Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Potansiyel Kar/Zarar',
                  style: TextStyle(fontSize: 16, color: Colors.white60),
                ),
                Text(
                  // 'TL ${_stockDetails['price'].toStringAsFixed(2)}',
                  'TL $potentialProfitLoss',
                  style: TextStyle(
                    fontSize: 32,
                    color: double.parse(potentialProfitLoss) >= 0
                        ? Theme.of(context).colorScheme.onSecondary
                        : Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
