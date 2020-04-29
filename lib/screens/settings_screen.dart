import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../widgets/auth/user_first_input.dart';
import '../widgets/notifications/notifications.dart';
import '../providers/authentication.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings-screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _notifications = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      getNotifications();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void deleteNotification(String id) {
    const url = 'http://3.80.155.110/api/notification/delete';
    http.post(
      url,
      body: json.encode({'id': id}),
      headers: {"Content-Type": "application/json"},
    );
    var index =
        _notifications.indexWhere((notif) => notif['_id']['\$oid'] == id);
    setState(() {
      _notifications.removeAt(index);
    });
  }

  void getNotifications() {
    var userId =
        Provider.of<AuthNotifier>(context, listen: false).getUserInfo['id'];
    const url = 'http://3.80.155.110/api/notification';
    setState(() {
      _isLoading = true;
    });
    http.post(
      url,
      body: json.encode({'receiver': userId}),
      headers: {"Content-Type": "application/json"},
    ).then(
      (response) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        setState(() {
          _isLoading = false;
          _notifications = extractedData;
        });
      },
    ).catchError((err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _showlogoutDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text("StockNinja'dan çıkış yapmak istiyor musunuz?"),
          actions: <Widget>[
            RaisedButton(
              color: Theme.of(context).colorScheme.primary,
              child: Text("İptal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Çıkış Yap"),
              onPressed: () {
                logoutUser();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void logoutUser() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('jwtToken');
    Provider.of<AuthNotifier>(context, listen: false).logoutUser();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, auth, child) {
        return SafeArea(
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: <Widget>[
              AppBar(
                title: Text(
                  '',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: Theme.of(context).colorScheme.background,
                brightness: Theme.of(context).brightness,
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Profil',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        ButtonTheme(
                          minWidth: 200,
                          child: RaisedButton(
                            onPressed: () {
                              auth.getUserAuthState
                                  ? _showlogoutDialog()
                                  : Navigator.of(context).push(
                                      new MaterialPageRoute<Null>(
                                        builder: (BuildContext context) {
                                          return UserFirstInput();
                                        },
                                        fullscreenDialog: true,
                                      ),
                                    );
                            },
                            color: auth.getUserAuthState
                                ? Theme.of(context).colorScheme.primaryVariant
                                : Theme.of(context).colorScheme.primary,
                            child: Text(
                              auth.getUserAuthState
                                  ? 'Çıkış Yap'
                                  : 'Giriş / Kayıt',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 100,
                      child: Image.asset(
                        "assets/images/ninja.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              !_isLoading
                  ? Notifications(
                      _notifications, getNotifications, deleteNotification)
                  : Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).primaryColor))),
            ],
          ),
        );
      },
    );
  }
}
