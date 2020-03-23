import 'package:flutter/material.dart';

class StockTransactionModal extends StatefulWidget {
  final String stockName;
  final Function transactionFunc;
  final String currentPrice;

  StockTransactionModal(
      this.stockName, this.transactionFunc, this.currentPrice);

  @override
  _StockTransactioneModalState createState() => _StockTransactioneModalState();
}

class _StockTransactioneModalState extends State<StockTransactionModal> {
  var _priceController;
  var _amountController;

  @override
  void initState() {
    _priceController = TextEditingController(text: widget.currentPrice);
    _amountController = TextEditingController();
    super.initState();
  }

  void _submitData() {
    final _enteredPrice = double.parse(_priceController.text);
    final _enteredAmount = int.parse(_amountController.text);
    widget.transactionFunc(_enteredPrice, _enteredAmount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        brightness: Theme.of(context).brightness,
        title: Text(''),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Card(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hisse Senedi Satın Al",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        var price = double.parse(_priceController.text) - 0.01;
                        if (price <= 0.01) {
                          price = 0.01;
                        }
                        _priceController.text = price.toStringAsFixed(2);
                      });
                    },
                    iconSize: 60,
                    icon: Icon(
                      Icons.arrow_left,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 70,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 3),
                        labelText: 'Price',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      controller: _priceController,
                      onSubmitted: (_) => _submitData(),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        var price = double.parse(_priceController.text) + 0.01;
                        _priceController.text = price.toStringAsFixed(2);
                      });
                    },
                    iconSize: 60,
                    icon: Icon(
                      Icons.arrow_right,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        var amount = double.parse(_amountController.text) - 0.1;
                        if (amount <= 0.1) {
                          amount = 0.1;
                        }
                        _amountController.text = amount.toStringAsFixed(2);
                      });
                    },
                    iconSize: 60,
                    icon: Icon(
                      Icons.arrow_left,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 70,
                    child: TextField(
                      autofocus: true,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 3),
                        labelText: 'Amount',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      controller: _amountController,
                      onSubmitted: (_) => _submitData(),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        var price = double.parse(_amountController.text) + 0.1;
                        _amountController.text = price.toStringAsFixed(2);
                      });
                    },
                    iconSize: 60,
                    icon: Icon(
                      Icons.arrow_right,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
              RaisedButton(
                focusColor: Theme.of(context).colorScheme.primary,
                child: Text('SATIN AL'),
                textColor: Colors.black,
                onPressed: () => _submitData(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
