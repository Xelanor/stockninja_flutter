import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Map transaction;

  TransactionCard(this.transaction);

  @override
  Widget build(BuildContext context) {
    DateTime date(date) {
      return DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    }

    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 200,
          width: double.infinity,
          // color: Theme.of(context).colorScheme.primaryVariant,
          color: Color.fromRGBO(12, 22, 50, 1),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${DateFormat('dd.MM.yyyy').add_Hm().format(date(transaction['date']))}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${transaction['informCount']}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.more_horiz),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${transaction['amount'].toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Adet',
                          style: TextStyle(fontSize: 12, color: Colors.white60),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '${transaction['current_value'].toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Değer',
                          style: TextStyle(fontSize: 12, color: Colors.white60),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${transaction['purchased_price'].toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Alış Fiyatı',
                          style: TextStyle(fontSize: 12, color: Colors.white60),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '${transaction['profit_loss'].toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: transaction['profit_rate'] >= 0
                                ? Theme.of(context).colorScheme.onSecondary
                                : Theme.of(context).colorScheme.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Değişim',
                          style: TextStyle(fontSize: 12, color: Colors.white60),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '% ${transaction['profit_rate'].toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 18,
                              color: transaction['profit_rate'] >= 0
                                  ? Theme.of(context).colorScheme.onSecondary
                                  : Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Kar / Zarar Oranı',
                          style: TextStyle(fontSize: 12, color: Colors.white60),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
