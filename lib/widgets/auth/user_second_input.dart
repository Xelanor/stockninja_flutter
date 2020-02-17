import 'package:flutter/material.dart';

class UserSecondInput extends StatefulWidget {
  final Function passLogin;
  final String email;

  UserSecondInput(this.passLogin, this.email);

  @override
  _UserSecondInputState createState() => _UserSecondInputState();
}

class _UserSecondInputState extends State<UserSecondInput> {
  final _passCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            child: FlatButton(
              child: Icon(
                Icons.arrow_back,
                size: 30,
              ),
              onPressed: () {},
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'E-Posta adresinize gönderilen güvenlik kodu 15 dakika geçerlidir.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Container(
                child: TextField(
                  style: TextStyle(fontSize: 22, letterSpacing: 12),
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: _passCodeController,
                  decoration: InputDecoration(
                    fillColor: Colors.black45,
                    counterText: '',
                    contentPadding: EdgeInsets.all(0),
                    hintText: "1 2 3 4 5 6",
                    hintStyle: TextStyle(letterSpacing: 12),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                onPressed: () {
                  if (_passCodeController.text.length == 6) {
                    widget.passLogin(widget.email, _passCodeController.text);
                  }
                },
                child: Text(
                  'KODU GİR',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
