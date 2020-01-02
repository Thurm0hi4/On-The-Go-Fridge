import 'package:flutter/material.dart';
import 'package:onthegofridge/controller/myfirebase.dart';
import 'package:onthegofridge/view/mydialog.dart';
import 'package:onthegofridge/view/signuppage.dart';

class SignUpPageController {
  SignUpPageState state;

  SignUpPageController(this.state);

  String validateEmail(String value) {
    if (value == null || !value.contains('.') || !value.contains('@')) {
      return 'Enter a Valid Email Address';
    }
    return null;
  }

  void saveEmail(String value) {
    state.user.email = value;
  }

  String validatePassword(String value) {
    if (value == null || value.length < 6) {
      return 'Enter a valid password';
    }
    return null;
  }

  void savePassword(String value) {
    state.user.password = value;
  }

  String validateDisplayName(String value) {
    if (value == null || value.length < 3) {
      return 'Enter at least 3 characters';
    }
    return null;
  }

  void saveDisplayName(String value) {
    state.user.displayName = value;
  }

  String validateZip(String value) {
    if (value == null || value.length != 5) {
      return 'Enter a Valid 5 digit ZIP code';
    }
    try {
      int n = int.parse(value);
      if (n < 10000) {
        return 'Enter a Valid 5 digit ZIP code';
      }
    } catch (e) {
      return 'Enter a 5 digit ZIP code';
    }
    return null;
  }

  void saveZip(String value) {
    state.user.zip = int.parse(value);
  }

  void createAccount() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }

    state.formKey.currentState.save();
    try {
      state.user.uid = await MyFirebase.createAccount(
        email: state.user.email,
        password: state.user.password,
      );
    } catch (e) {
      MyDialog.info(
        context: state.context,
        title: 'Account Creation Failed',
        message: e.message != null ? e.message : e.toString(),
        action: () => Navigator.pop(state.context),
      );
      return;
    }
    try{
      MyFirebase.createProfile(state.user);
    } catch(e){
      state.user.displayName = null;
      state.user.zip = null;
      state.user.personURL = null;
    }

    MyDialog.info(
      context: state.context,
      title: 'Account Creation Successfully',
      message: 'Your Account is created with ${state.user.email}',
      action: () => Navigator.pop(state.context),
    );

  }
}
