import 'package:flutter/material.dart';

class StockSellTransactionModal extends StatefulWidget {
  final Function transactionFunc;
  final String currentPrice;
  final String currentAmount;

  StockSellTransactionModal(
      this.transactionFunc, this.currentPrice, this.currentAmount);

  @override
  _StockSellTransactioneModalState createState() =>
      _StockSellTransactioneModalState();
}

class _StockSellTransactioneModalState
    extends State<StockSellTransactionModal> {
  var _priceController;
  var _amountController;
  var _amountErrorText = "";

  @override
  void initState() {
    _priceController = TextEditingController(text: widget.currentPrice);
    _amountController = TextEditingController(text: widget.currentAmount);
    super.initState();
  }

  void _submitData() {
    if (double.parse(_amountController.text) >
        double.parse(widget.currentAmount)) {
      setState(() {
        _amountErrorText = "Elinizdeki miktardan fazlasını satamazsınız!";
      });
    } else if (double.parse(_amountController.text) <= 0) {
      setState(() {
        _amountErrorText =
            "Satış yapmak istediğiniz miktar 0'dan fazla olmalıdır!";
      });
    } else {
      final _enteredPrice = double.parse(_priceController.text);
      final _enteredAmount = double.parse(_amountController.text);
      widget.transactionFunc(_enteredPrice, _enteredAmount);

      Navigator.of(context).pop();
    }
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Hisse Senedi Sat",
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Fiyat',
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
                  labelText: 'Adet',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                controller: _amountController,
                onSubmitted: (_) => _submitData(),
              ),
              _amountErrorText.length > 0
                  ? Text(
                      _amountErrorText,
                      style: TextStyle(color: Colors.red),
                    )
                  : Container(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    focusColor: Theme.of(context).colorScheme.primary,
                    child: Text('SAT'),
                    textColor: Colors.black,
                    onPressed: () => _submitData(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
