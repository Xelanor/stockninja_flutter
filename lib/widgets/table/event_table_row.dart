import 'package:flutter/material.dart';

import './stock_table_str_cell.dart';
import './event_table_int_cell.dart';

class EventTableRow extends StatelessWidget {
  final Map stock;

  EventTableRow(this.stock);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 1.5),
      child: Row(
        children: [
          Expanded(
            child: StockTableStrCell(stock['date']),
            flex: 30,
          ),
          Expanded(
            child: EventTableIntCell(stock['decreasing'].toString()),
            flex: 20,
          ),
          Expanded(
            child: EventTableIntCell(stock['increasing'].toString()),
            flex: 20,
          ),
          Expanded(
            child: EventTableIntCell(stock['same'].toString()),
            flex: 20,
          ),
        ],
      ),
    );
  }
}
