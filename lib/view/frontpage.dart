import 'package:flutter/material.dart';
import 'package:onthegofridge/controller/frontpage_controller.dart';
import 'package:onthegofridge/model/user.dart';

class FrontPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FrontPageState();
  }
}

class FrontPageState extends State<FrontPage> {
  FrontPageController controller;
  BuildContext context;
  var user = User();
  var formKey = GlobalKey<FormState>();

  FrontPageState() {
    controller = FrontPageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('OnTheGoFridge'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.people, color: Colors.white),
            label:
                Text('Create Account', style: TextStyle(color: Colors.white)),
            onPressed: controller.createAccount,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    child: Image.asset(
                      "assets/Fridge3.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  TextFormField(
                    initialValue: user.email,
                    decoration: InputDecoration(
                      icon: new Icon(
                        Icons.mail,
                        color: Colors.grey,
                      ),
                      labelText: 'Email',
                      hintText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: controller.validateEmail,
                    onSaved: controller.saveEmail,
                  ),
                  TextFormField(
                    initialValue: user.password,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: new Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                      labelText: 'Password',
                      hintText: 'Password',
                    ),
                    validator: controller.validatePassword,
                    onSaved: controller.savePassword,
                  ),
                  RaisedButton(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    child: Text('Login'),
                    onPressed: controller.login,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  FlatButton(
                    onPressed: controller.resetPassword,
                    child: new Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: new Text(
                          "Forgot Password?",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 15.0),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
