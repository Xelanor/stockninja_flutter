import 'package:flutter/material.dart';

class StockTargetModal extends StatefulWidget {
  final String stockName;
  final Function setTarget;
  final String currentPrice;

  StockTargetModal(this.stockName, this.setTarget, this.currentPrice);

  @override
  _StockTargetModalState createState() => _StockTargetModalState();
}

class _StockTargetModalState extends State<StockTargetModal> {
  var _buyTargetController;
  var _sellTargetController;

  @override
  void initState() {
    _buyTargetController = TextEditingController(text: widget.currentPrice);
    _sellTargetController = TextEditingController(text: widget.currentPrice);
    super.initState();
  }

  void _submitData(type) {
    if (type == "buy") {
      final enteredBuyTarget = double.parse(_buyTargetController.text);
      widget.setTarget(type, enteredBuyTarget);
    }

    if (type == "sell") {
      final enteredSellTarget = double.parse(_sellTargetController.text);
      widget.setTarget(type, enteredSellTarget);
    }

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
                  "Hedef Gir",
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Alış Hedefi',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                controller: _buyTargetController,
                onSubmitted: (_) => _submitData("buy"),
              ),
              RaisedButton(
                child: Text('Alış Hedefi Gir'),
                textColor: Colors.black,
                onPressed: () => _submitData("buy"),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Satış Hedefi',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                controller: _sellTargetController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData("sell"),
              ),
              RaisedButton(
                child: Text('Satış Hedefi Gir'),
                textColor: Colors.black,
                onPressed: () => _submitData("sell"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
