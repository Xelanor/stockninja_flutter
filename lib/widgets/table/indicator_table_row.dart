import 'package:flutter/material.dart';

import '../../screens/stock_details_screen.dart';
import './event_table_str_cell.dart';
import './event_table_int_cell.dart';

class IndicatorTableRow extends StatelessWidget {
  final Map stock;

  IndicatorTableRow(this.stock);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                StockDetailsScreen(stock['name'], stock['ninja'] >= 0),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 1.5),
        child: Row(
          children: [
            Expanded(
              child: EventTableStrCell(stock['name']),
              flex: 25,
            ),
            Expanded(
              child: EventTableIntCell(stock['rsi'].toStringAsFixed(2)),
              flex: 20,
            ),
            Expanded(
              child: EventTableIntCell(stock['ninja'].toStringAsFixed(2)),
              flex: 20,
            ),
            Expanded(
              child: EventTableIntCell(stock['fk'].toStringAsFixed(2)),
              flex: 20,
            ),
            Expanded(
              child: EventTableIntCell(stock['pd_dd'].toStringAsFixed(2)),
              flex: 20,
            ),
            Expanded(
              child: EventTableIntCell(
                  (stock['fk'] / stock['pd_dd']).toStringAsFixed(2)),
              flex: 20,
            ),
          ],
        ),
      ),
    );
  }
}
