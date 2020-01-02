import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onthegofridge/controller/homepage_controller.dart';
import 'package:onthegofridge/model/diet.dart';
import 'package:onthegofridge/model/food.dart';
import 'package:onthegofridge/model/nutrition.dart';
import 'package:onthegofridge/model/recipe.dart';
import 'package:onthegofridge/model/user.dart';

class HomePage extends StatefulWidget {
  final User user;
  final List<Food> itemList;

  HomePage(this.user, this.itemList);
  @override
  State<StatefulWidget> createState() {
    return HomePageState(user, itemList);
  }
}

class HomePageState extends State<HomePage> {
  User user;
  Recipe recipe;
  Diet diet;
  Nutrition nutrition;
  HomePageController controller;
  BuildContext context;

  List<Food> itemList;
  List<int> deleteIndices;

  HomePageState(this.user, this.itemList) {
    controller = HomePageController(this);
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
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fridge Home'),
          actions: deleteIndices == null
              ? null
              : <Widget>[
                  FlatButton.icon(
                    label: Text('Delete'),
                    icon: Icon(Icons.delete),
                    onPressed: controller.deleteButton,
                  ),
                ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(user.displayName),
                accountEmail: Text(user.email),
                currentAccountPicture: CachedNetworkImage(
                  imageUrl: user.personURL,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error_outline),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person_add),
                title: Text('Account Page'),
                onTap: controller.addImage,
              ),
              ListTile(
                leading: Icon(Icons.people),
                title: Text('Shared With Me'),
                onTap: controller.sharedWithMeMenu,
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: Text('Recipes'),
                onTap: controller.findRecipe,
              ),
              ListTile(
                leading: Icon(Icons.lock_open),
                title: Text('Reset Password'),
                onTap: controller.resetPass,
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sign Out'),
                onTap: controller.signOut,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: controller.addButton,
        ),
        body: ListView.builder(
          itemCount: itemList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(5.0),
              color: deleteIndices != null && deleteIndices.contains(index)
                  ? Colors.cyan[200]
                  : Colors.white,
              child: ListTile(
                leading: CachedNetworkImage(
                  imageUrl: itemList[index].image,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error_outline),
                ),
                title: Text(itemList[index].name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(user.displayName),
                    Text(itemList[index].description),
                    Text(itemList[index].amount.toString()),
                  ],
                ),
                onTap: () => controller.onTap(index),
                onLongPress: () => controller.longPress(index),
              ),
            );
          },
        ),
      ),
    );
  }
}
