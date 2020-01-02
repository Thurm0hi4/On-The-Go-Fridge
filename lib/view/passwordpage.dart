import 'package:flutter/material.dart';
import 'package:onthegofridge/controller/passwordpage_controller.dart';
import 'package:onthegofridge/model/user.dart';

class PasswordPage extends StatefulWidget {
  final User user;

  PasswordPage(this.user);

  @override
  State<StatefulWidget> createState() {
    return PasswordPageState(
      this.user,
    );
  }
}

class PasswordPageState extends State<PasswordPage> {
  User user;

  PasswordPageController controller;
  BuildContext context;
  var formKey = GlobalKey<FormState>();

  PasswordPageState(this.user) {
    controller = PasswordPageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 150.0,
            ),
            TextFormField(
              initialValue: user.email,
              decoration: InputDecoration(
                labelText:
                    'Please enter the email associated with your Account',
                hintText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: controller.validateEmail,
              onSaved: controller.saveEmail,
            ),
            SizedBox(
              height: 50.0,
            ),
            RaisedButton(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    child: Text('Reset Password'),
                    onPressed: controller.resetPass,
                  ),
          ],
        ),
      ),
    );
  }
}
