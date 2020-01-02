import 'package:flutter/material.dart';
import 'package:onthegofridge/controller/signuppage_controller.dart';
import 'package:onthegofridge/model/user.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> {
  SignUpPageController controller;
  BuildContext context;
  var formKey = GlobalKey<FormState>();
  User user = User();

  SignUpPageState() {
    controller = SignUpPageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: user.email,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Email (as login name)',
                  labelText: 'Email',
                ),
                validator: controller.validateEmail,
                onSaved: controller.saveEmail,
              ),
              TextFormField(
                initialValue: user.password,
                autocorrect: false,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                ),
                validator: controller.validatePassword,
                onSaved: controller.savePassword,
              ),
              TextFormField(
                initialValue: user.displayName,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Display Name',
                  labelText: 'Display Name',
                ),
                validator: controller.validateDisplayName,
                onSaved: controller.saveDisplayName,
              ),
              TextFormField(
                initialValue: user.zip.toString(),
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Zip Code',
                  labelText: 'Zip Code',
                ),
                validator: controller.validateZip,
                onSaved: controller.saveZip,
              ),
              RaisedButton(
                child: Text('Create Account'),
                onPressed: controller.createAccount,
              ),
            ],
          )),
    );
  }
}
