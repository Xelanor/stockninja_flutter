import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import './user_second_input.dart';

class UserFirstInput extends StatefulWidget {
  @override
  _UserFirstInputState createState() => _UserFirstInputState();
}

class _UserFirstInputState extends State<UserFirstInput> {
  final _emailController = TextEditingController();
  bool _nextButtonEnabled = false;
  var _isLoading = false;

  void initialRegister() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();

    var playerId = status.subscriptionStatus.userId;
    const url = 'http://54.196.2.46/api/auth/signup';
    setState(() {
      _isLoading = true;
    });
    http.post(
      url,
      body: json.encode({'email': _emailController.text, 'notifId': playerId}),
      headers: {"Content-Type": "application/json"},
    ).then((res) {
      if (res.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).push(
          new MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return UserSecondInput(_emailController.text);
            },
            fullscreenDialog: true,
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
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
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'E-Posta adresiniz nedir?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: TextField(
                    autocorrect: false,
                    autofocus: true,
                    controller: _emailController,
                    onChanged: (value) {
                      if (value.length > 3 &&
                          value.contains('@') &&
                          value.contains('.')) {
                        setState(() {
                          _nextButtonEnabled = true;
                        });
                      } else {
                        setState(() {
                          _nextButtonEnabled = false;
                        });
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.grey[900],
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        hintText: "E-posta Adresi",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 44,
                    child: RaisedButton(
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: _nextButtonEnabled
                          ? () {
                              if (_emailController.text != '') {
                                initialRegister();
                              }
                            }
                          : null,
                      disabledColor: Colors.grey.shade900,
                      disabledTextColor: Colors.grey.shade700,
                      textColor: Colors.white,
                      child: _isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      Theme.of(context).colorScheme.secondary)),
                            )
                          : Text(
                              'Devam et',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
