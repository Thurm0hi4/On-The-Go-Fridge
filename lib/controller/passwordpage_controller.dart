import 'package:flutter/material.dart';
import 'package:onthegofridge/controller/myfirebase.dart';
import 'package:onthegofridge/view/frontpage.dart';
import 'package:onthegofridge/view/mydialog.dart';
import 'package:onthegofridge/view/passwordpage.dart';

class PasswordPageController {
  PasswordPageState state;
  PasswordPageController(this.state);

  String validateEmail(String value) {
    if (value == null || !value.contains('.') || !value.contains('@')) {
      return 'Enter a Valid Email Address';
    }
    return null;
  }

  void saveEmail(String value) {
    state.user.email = value;
  }

  void resetPass() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }

    state.formKey.currentState.save();

    try {
        await MyFirebase.resetPassword(state.user);
    } catch (e) {
      state.user.displayName = null;
      state.user.zip = null;
      state.user.personURL = null;
    }
    MyDialog.info(
      context: state.context,
      title: 'Account Password Reset Successfully Sent',
      message: 'Your Password reset email has been sent to ${state.user.email}',
      action: () => Navigator.push(state.context, MaterialPageRoute(
        builder: (context) => FrontPage(),
      )),
    );
  }
}