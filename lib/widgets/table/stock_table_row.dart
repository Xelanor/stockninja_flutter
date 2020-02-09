import 'package:flutter/material.dart';

import '../../screens/stock_details_screen.dart';
import './stock_table_str_cell.dart';
import './stock_table_int_cell.dart';

class StockTableRow extends StatelessWidget {
  final Map stock;

  StockTableRow(this.stock);

  @override
  Widget build(BuildContext context) {
    bool increasing = stock['rate'] >= 0;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                StockDetailsScreen(stock['stockName'], increasing),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 1.5),
        child: Row(
          children: [
            Expanded(
              child: StockTableStrCell(stock['stockName']),
              flex: 25,
            ),
            Expanded(
              child: StockTableIntCell(stock['price'].toString(), increasing),
              flex: 20,
            ),
            Expanded(
              child: StockTableStrCell(stock['dayRange']),
              flex: 35,
            ),
            Expanded(
              child: StockTableIntCell(stock['rate'].toString(), increasing),
              flex: 20,
            ),
          ],
        ),
      ),
    );
  }
}
