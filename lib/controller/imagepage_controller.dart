import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onthegofridge/controller/myfirebase.dart';
import 'package:onthegofridge/view/imagepage.dart';
import 'package:onthegofridge/view/mydialog.dart';

class ImagePageController {
  ImagePageState state;
  ImagePageController(this.state);

  String validateImage(String value) {
    if (value != null && value.length >= 4 && value.substring(0, 4) == 'http') {
      return null;
    }
    return "Invalide URL for the image";
  }

  void saveImage(String value) {
    state.user.personURL = value;
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

  void updateAccount() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }

    state.formKey.currentState.save();

    try {
      if (state.user == null) {
        state.user.uid = await MyFirebase.createAccount(
          email: state.user.email,
          password: state.user.password,
        );
      } else {
        await MyFirebase.updateAccount(state.user);
      }
    } catch (e) {
      state.user.displayName = null;
      state.user.zip = null;
      state.user.personURL = null;
    }

    MyDialog.info(
      context: state.context,
      title: 'Account Update Successful',
      message: 'Your Account was successfully updated and the password reset has been sent',
      action: () => Navigator.pop(state.context),
    );
  }
}
