import 'package:flutter/material.dart';

import '../../screens/stock_details_screen.dart';
import './stock_table_title_cell.dart';
import './stock_table_str_cell.dart';
import './stock_table_int_cell.dart';

class StockTableMyRow extends StatelessWidget {
  final Map stock;
  final Function swipeFunction;

  StockTableMyRow(this.stock, this.swipeFunction);

  @override
  Widget build(BuildContext context) {
    bool increasing = stock['rate'] >= 0;

    return Dismissible(
      key: ValueKey(stock['stockName']),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        child: Icon(Icons.delete),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.all(1),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        if (swipeFunction(stock['stockName']) == true) {
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${stock['shortName']} porföyünden çıkartıldı!',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      },
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  StockDetailsScreen(stock['stockName'], increasing),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          padding: EdgeInsets.only(bottom: 1.5),
          child: Row(
            children: [
              Expanded(
                child:
                    StockTableTitleCell(stock['stockName'], stock['shortName']),
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
                child: StockTableIntCell(
                    '% ${stock['rate'].toString()}', increasing),
                flex: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
