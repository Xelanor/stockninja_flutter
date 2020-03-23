import 'package:flutter/material.dart';

import '../investments/stock_card.dart';

class InvestmentsList extends StatelessWidget {
  final Map transactions;
  final Function getStocks;

  InvestmentsList(this.transactions, this.getStocks);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          transactions['stock_values'].keys.toList().map<Widget>((stockName) {
        return StockCard(
            stockName, transactions['stock_values'][stockName], getStocks);
      }).toList(),
    );
  }
}
