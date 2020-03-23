import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../providers/authentication.dart';
import '../investments/stock_sell_modal.dart';

class TransactionCard extends StatefulWidget {
  final String stockName;
  final Map transaction;
  final Function refresh;

  TransactionCard(this.stockName, this.transaction, this.refresh);

  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  void deleteTransaction() {
    var id = widget.transaction['id'];
    const url = 'http://54.196.2.46/api/transaction/delete';
    http.post(
      url,
      body: json.encode({'id': id}),
      headers: {"Content-Type": "application/json"},
    ).then((res) {
      if (res.statusCode == 200) {
        widget.refresh();
      }
    });
  }

  void sellTransaction(price, amount) {
    var userId =
        Provider.of<AuthNotifier>(context, listen: false).getUserInfo['id'];
    const url = "http://54.196.2.46/api/transaction/sell";
    var profit = (price - widget.transaction['purchased_price']) * amount;
    http.post(url,
        body: json.encode({
          'id': widget.transaction['id'],
          'user': userId,
          'name': widget.stockName,
          'price': price,
          'amount': amount,
          'profit': profit,
          'kind': "sell"
        }),
        headers: {"Content-Type": "application/json"}).then((_) {
      widget.refresh();
    });
  }

  void startSellTransactionModal(BuildContext ctx) {
    Navigator.of(ctx).push(
      new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return StockSellTransactionModal(
            sellTransaction,
            widget.transaction['purchased_price'].toStringAsFixed(2),
            widget.transaction['remaining'].toStringAsFixed(2),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime date(date) {
      return DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
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
                      '${DateFormat('dd.MM.yyyy').add_Hm().format(date(widget.transaction['date']))}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${widget.transaction['informCount']}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: PopupMenuButton(
                        tooltip: "Seçenekler",
                        padding: EdgeInsets.only(bottom: 24),
                        offset: Offset(50.0, 50.0),
                        onSelected: (String selectedValue) {
                          if (selectedValue == "delete") {
                            deleteTransaction();
                          } else if (selectedValue == "sell") {
                            startSellTransactionModal(context);
                          }
                        },
                        color: Theme.of(context).colorScheme.primaryVariant,
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                        itemBuilder: (_) => [
                          PopupMenuItem(
                              height: 24,
                              child: (Text(
                                'Sil',
                                style: TextStyle(fontSize: 14),
                              )),
                              value: "delete"),
                          PopupMenuItem(
                              height: 24,
                              child: (Text(
                                'Sat',
                                style: TextStyle(fontSize: 14),
                              )),
                              value: "sell"),
                        ],
                      ),
                    ),
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
                          '${widget.transaction['remaining'].toStringAsFixed(0)}',
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
                          '${widget.transaction['current_value'].toStringAsFixed(2)}',
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
                          '${widget.transaction['purchased_price'].toStringAsFixed(2)}',
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
                          '${widget.transaction['profit_loss'].toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: widget.transaction['profit_rate'] >= 0
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
                          '% ${widget.transaction['profit_rate'].toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 18,
                              color: widget.transaction['profit_rate'] >= 0
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
