import 'package:flutter/material.dart';

class UserFirstInput extends StatefulWidget {
  final Function authFunction;

  UserFirstInput(this.authFunction);

  @override
  _UserFirstInputState createState() => _UserFirstInputState();
}

class _UserFirstInputState extends State<UserFirstInput> {
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: TextField(
            textCapitalization: TextCapitalization.characters,
            controller: _emailController,
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
                fillColor: Colors.transparent,
                filled: true,
                contentPadding: EdgeInsets.all(0),
                labelText: "E-posta Adresi",
                labelStyle: TextStyle(color: Colors.white),
                hintText: "E-posta Adresi",
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)))),
          ),
        ),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Kayıt Ol',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  if (_emailController.text != '') {
                    widget.authFunction(_emailController.text);
                  }
                },
                elevation: 0,
                child: Icon(Icons.arrow_forward),
              )
            ],
          ),
        ),
      ],
    );
  }
}
