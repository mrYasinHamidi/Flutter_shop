import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function onUserNameSaved;
  final Function onPasswordSaved;

  LoginForm(
      {@required this.formKey, this.onUserNameSaved, this.onPasswordSaved});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp('[a-zA-Z0-9]'),
                  ),
                ],
                decoration: InputDecoration(
                  labelText: 'User Name',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.person),
                ),
                onSaved: (value) {
                  widget.onUserNameSaved(value.trim());
                },
                validator: (value) {
                  if (value.trim().length < 4)
                    return 'most have 4 character or more';
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                obscureText: true,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp('[a-zA-Z0-9]'),
                  ),
                ],
                decoration: InputDecoration(
                  // icon: Icon(Icons.person),
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.vpn_key_sharp),
                ),
                onSaved: (value) {
                  widget.onPasswordSaved(value.trim());
                },
                validator: (value) {
                  if (value.trim().length < 4)
                    return 'most have 4 character or more';
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
