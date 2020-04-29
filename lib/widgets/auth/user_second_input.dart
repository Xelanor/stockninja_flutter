import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../utils/jwt_decode.dart';
import '../../providers/authentication.dart';

class UserSecondInput extends StatefulWidget {
  final String email;

  UserSecondInput(this.email);

  @override
  _UserSecondInputState createState() => _UserSecondInputState();
}

class _UserSecondInputState extends State<UserSecondInput> {
  final _passCodeController = TextEditingController();

  void passLogin(String email) {
    var url = 'http://3.80.155.110/api/auth/login/${_passCodeController.text}';
    http.post(
      url,
      body: json.encode({'email': email}),
      headers: {"Content-Type": "application/json"},
    ).then((res) async {
      if (res.statusCode == 200) {
        var prefs = await SharedPreferences.getInstance();
        var token = json.decode(res.body)['token'];
        prefs.setString('jwtToken', token);
        var decoded = jwtDecode(token);
        var userInfo = json.decode(decoded['identity']);
        Provider.of<AuthNotifier>(context, listen: false).setUserInfo(userInfo);
        Navigator.of(context).popUntil((r) => r.settings.isInitialRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          brightness: Theme.of(context).brightness,
          title: Text(''),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'E-Posta adresinize gönderilen güvenlik kodu 15 dakika geçerlidir.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                child: TextField(
                  style: TextStyle(fontSize: 22, letterSpacing: 12),
                  maxLength: 4,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: _passCodeController,
                  decoration: InputDecoration(
                    fillColor: Colors.black45,
                    counterText: '',
                    contentPadding: EdgeInsets.all(0),
                    hintText: "1 2 3 4",
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        if (_passCodeController.text.length == 4) {
                          passLogin(widget.email);
                        }
                      },
                      child: Text(
                        'KODU GİR',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((r) => r.settings.isInitialRoute);
                      },
                      child: Text(
                        'İPTAL ET',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    )
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
