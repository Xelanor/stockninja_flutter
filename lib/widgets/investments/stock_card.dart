import 'package:flutter/material.dart';

import './transaction_card.dart';

class StockCard extends StatefulWidget {
  final String stockName;
  final Map information;

  StockCard(this.stockName, this.information);

  @override
  _StockCardState createState() => _StockCardState();
}

class _StockCardState extends State<StockCard> {
  var _transactionsOpened = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                _transactionsOpened = !_transactionsOpened;
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 220,
                width: double.infinity,
                // color: Theme.of(context).colorScheme.primaryVariant,
                color: Color.fromRGBO(3, 22, 37, 1),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${widget.stockName}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '${widget.information['informCount']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Haber Sayısı',
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.white60),
                                  ),
                                ],
                              ),
                              SizedBox(width: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    '${widget.information['amount']}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Adet',
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.white60),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Divider(
                        height: 0,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'TL ${widget.information['current_value'].toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Değer',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white60),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'TL ${widget.information['profit_loss'].toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: widget.information['profit_loss'] >= 0
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                      : Theme.of(context).colorScheme.error,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Kar / Zarar',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white60),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'TL ${widget.information['unit_cost'].toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Ortalama Alış Fiyatı',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white60),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                '% ${widget.information['profit_rate'].toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: widget.information['profit_loss'] >= 0
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                      : Theme.of(context).colorScheme.error,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Oran',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white60),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '${widget.information['transactions'].length} Yatırım',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 18,
                                    height: 1,
                                    fontWeight: FontWeight.w600),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Theme.of(context).colorScheme.primary,
                                size: 32,
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          _transactionsOpened
              ? Column(
                  children:
                      widget.information['transactions'].map<Widget>((info) {
                    return TransactionCard(info);
                  }).toList(),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
