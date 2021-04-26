import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shop_hive/components/LoginForm.dart';
import 'package:shop_hive/main.dart';

class LoginPage extends StatefulWidget {
  final bool isLogIn;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginPage({this.isLogIn = true});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Box<String> _userBox;

  @override
  void initState() {
    super.initState();
    _userBox = Hive.box(userBoxKey);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  width: width,
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.deepOrange, Colors.orange]),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  right: 50,
                  child: Text(
                    widget.isLogIn ? 'LogIn' : 'Profile',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: LoginForm(
                    formKey: widget.formKey,
                    onUserNameSaved: (value) {
                      _userBox.put('0', value);
                    },
                    onPasswordSaved: (value) {
                      _userBox.put('1', value);
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //   child: Visibility(
                //     visible: widget.isLogIn,
                //     child: Text(
                //       'Forget Password?',
                //       textAlign: TextAlign.end,
                //       style: TextStyle(color: Colors.black87),
                //     ),
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: GestureDetector(
                  child: Container(
                    width: width * 0.8,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      gradient: LinearGradient(
                          colors: [Colors.orange, Colors.deepOrange]),
                    ),
                    child: Center(
                      child: Text(
                        widget.isLogIn ? 'LOGIN' : 'SAVE',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (widget.formKey.currentState.validate())
                      widget.formKey.currentState.save();
                    if (widget.isLogIn)
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                  },
                ),
              ),
            ),
            Visibility(
              visible: widget.isLogIn,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Colors.black87),
                  ),
                  Text(
                    'Register',
                    style: TextStyle(color: Colors.orange),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
