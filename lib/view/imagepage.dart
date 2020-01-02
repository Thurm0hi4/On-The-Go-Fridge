import 'package:flutter/material.dart';
import 'package:onthegofridge/controller/imagepage_controller.dart';
import 'package:onthegofridge/model/user.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImagePage extends StatefulWidget {
  final User user;
  ImagePage(this.user);
  @override
  State<StatefulWidget> createState() {
    return ImagePageState(user);
  }
}

class ImagePageState extends State<ImagePage> {
  User user;
  ImagePageController controller;
  BuildContext context;
  var formKey = GlobalKey<FormState>();

  ImagePageState(this.user) {
    controller = ImagePageController(this);
    if (user.personURL == null) {
      user.personURL = '';
    }
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Page'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: user.personURL,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error_outline, size: 200),
              height: 200,
              width: 200,
            ),
            TextFormField(
              initialValue: user.personURL,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Image URL',
                labelText: 'Image URL',
              ),
              validator: controller.validateImage,
              onSaved: controller.saveImage,
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
              child: Text('Update Account'),
              onPressed: controller.updateAccount,
            ),
          ],
        ),
      ),
    );
  }
}
