import 'package:flutter/material.dart';
import '../controller/myfirebase.dart';
import '../view/mydialog.dart';
import '../view/fridgeitempage.dart';

class FridgeitemPageController {
  FridgeitemPageState state;
  FridgeitemPageController(this.state);

  String validateImgUrl(String value) {
    if (value == null || value.length < 5) {
      return 'Enter Image Url beginning with http';
    }
    return null;
  }

  void saveImgUrl(String value) {
    state.foodCopy.image = value;
  }

  String validateName(String value) {
    if (value == null) {
      return 'Enter Item Name';
    }
    return null;
  }

  void saveName(String value) {
    state.foodCopy.name = value;
  }

  String validateDescription(String value) {
    if (value == null || value.length < 10) {
      return 'Enter an item description';
    }
    return null;
  }

  void saveDescription(String value) {
    state.foodCopy.description = value;
  }

  String validateAmount(String value) {
    if (value == null || int.parse(value) == 0) {
      return 'Enter an Item Amount';
    }
    try {
      int.parse(value);
    } catch (e) {
      return 'Enter an Amount';
    }
    return null;
  }

  void saveAmount(String value) {
    state.foodCopy.amount = int.parse(value);
  }

  String validateSharedWith(String value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    for (var email in value.split(',')) {
      if (!(email.contains('.') && email.contains('@'))) {
        return 'Enter comma(,) separated email list';
      }
      if (email.indexOf('@') != email.lastIndexOf('@')) {
        return 'Enter comma(,) separated email list';
      }
    }
    return null;
  }

  void saveSharedWith(String value) {
    if (value == null || value.trim().isEmpty) {
      return;
    }
    state.foodCopy.sharedWith = [];
    List<String> emaillist = value.split(',');
    for (var email in emaillist) {
      state.foodCopy.sharedWith.add(email.trim());
    }
  }

  String validateBarcode(String value) {
    if (value == null || value.length != 12) {
      return 'Enter a valid barcode';
    }
    return null;
  }

  void saveBarcode(String value) {
    state.foodCopy.barcode = int.parse(value);
  }

  void save() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }
    state.formKey.currentState.save();
    state.foodCopy.createdBy = state.user.email;
    state.foodCopy.lastUpdatedAt = DateTime.now();
    try {
      if (state.food == null) {
        state.foodCopy.documentID = await MyFirebase.addFridgeItem(state.foodCopy);
      } else {
        await MyFirebase.updateFridgeItem(state.foodCopy);
      }
      Navigator.pop(state.context, state.foodCopy);
    } catch (e) {
      MyDialog.info(
        context: state.context,
        title: 'Firestore save error',
        message: 'Firestore is unavailable',
        action: () {
          Navigator.pop(state.context);
          Navigator.pop(state.context, null);
        },
      );
    }
  }
}