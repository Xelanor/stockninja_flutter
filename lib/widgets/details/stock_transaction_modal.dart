import 'package:flutter/material.dart';

class StockTransactionModal extends StatefulWidget {
  final String stockName;
  final Function transactionFunc;
  final String type;
  final String currentPrice;

  StockTransactionModal(
      this.stockName, this.transactionFunc, this.type, this.currentPrice);

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
    widget.transactionFunc(widget.type, _enteredPrice, _enteredAmount);

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
                alignment: Alignment.center,
                child: Text(
                  widget.type == "buy"
                      ? "Hisse Senedi Satın Al"
                      : "Hisse Senedi Sat",
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                controller: _priceController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                controller: _amountController,
                onSubmitted: (_) => _submitData(),
              ),
              RaisedButton(
                focusColor: Theme.of(context).colorScheme.primary,
                child: widget.type == "buy" ? Text('BUY') : Text('SELL'),
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
