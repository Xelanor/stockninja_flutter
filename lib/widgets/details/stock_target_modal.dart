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
  double _buyTarget;
  double _sellTarget;

  @override
  void initState() {
    _buyTarget = double.parse(widget.currentPrice);
    _sellTarget = double.parse(widget.currentPrice);
    super.initState();
  }

  void _submitData(type) {
    if (type == "buy") {
      final enteredBuyTarget = double.parse(_buyTarget.toStringAsFixed(2));
      widget.setTarget(type, enteredBuyTarget);
    }

    if (type == "sell") {
      final enteredSellTarget = double.parse(_sellTarget.toStringAsFixed(2));
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Şu anki Fiyat: ",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "${widget.currentPrice}",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Alış Hedefi: ${_buyTarget.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 15),
                  ),
                  Expanded(
                    child: Slider(
                      value: _buyTarget.toDouble(),
                      min: double.parse(widget.currentPrice) * 0.85,
                      max: double.parse(widget.currentPrice) * 1.15,
                      divisions: 100,
                      label: '${_buyTarget.toStringAsFixed(2)}',
                      onChanged: (double newValue) {
                        setState(() {
                          _buyTarget = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      'Alış Hedefi Gir',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    textColor: Colors.black,
                    onPressed: () => _submitData("buy"),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Satış Hedefi: ${_sellTarget.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 15),
                  ),
                  Expanded(
                    child: Slider(
                      value: _sellTarget.toDouble(),
                      min: double.parse(widget.currentPrice) * 0.9,
                      max: double.parse(widget.currentPrice) * 1.1,
                      divisions: 100,
                      label: '${_sellTarget.toStringAsFixed(2)}',
                      onChanged: (double newValue) {
                        setState(() {
                          _sellTarget = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      'Satış Hedefi Gir',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    textColor: Colors.black,
                    onPressed: () => _submitData("sell"),
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
