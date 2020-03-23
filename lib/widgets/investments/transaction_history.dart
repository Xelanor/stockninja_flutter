import 'package:flutter/material.dart';

import '../investments/transaction_history_card.dart';

class TransactionHistory extends StatelessWidget {
  final Map transactions;

  TransactionHistory(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions['result'].map<Widget>((transaction) {
        return TransactionHistoryCard(transaction);
      }).toList(),
    );
  }
}
