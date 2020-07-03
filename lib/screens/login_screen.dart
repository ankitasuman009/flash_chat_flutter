import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  bool _spinnerStatus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
      inAsyncCall: _spinnerStatus,
        child: Padding(

          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                  //Do something with the user input.
                },
                decoration:
                    kHintMessageDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: kHintMessageDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundButton(Colors.teal.shade500, () async {
                setState(() {
                  _spinnerStatus = true;
                });
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) Navigator.pushNamed(context, ChatScreen.id);
                  setState(() {
                    _spinnerStatus = false;
                  });
                } catch (e) {
                  print(e);
                }
              }, 'Log In'),
            ],
          ),
        ),
      ),
    );
  }
}
