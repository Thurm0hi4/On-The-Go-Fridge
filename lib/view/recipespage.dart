import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onthegofridge/controller/recipespage_controller.dart';
import 'package:onthegofridge/model/diet.dart';
import 'package:onthegofridge/model/nutrition.dart';
import 'package:onthegofridge/model/recipe.dart';
import 'package:onthegofridge/model/user.dart';

class RecipePage extends StatefulWidget {
  final User user;
  final Recipe recipe;
  final Diet diet;
  final Nutrition nutrition;
  RecipePage(this.user, this.recipe, this.nutrition, this.diet);
  @override
  State<StatefulWidget> createState() {
    return RecipePageState(this.user, this.recipe, this.diet, this.nutrition);
  }
}

class RecipePageState extends State<RecipePage> {
  RecipePageController controller;
  BuildContext context;
  var formKey = GlobalKey<FormState>();
  User user;
  Recipe recipe;
  Diet diet;
  Nutrition nutrition;

  Widget appBarTitle = Text('Recipes');
  Icon actionIcon = Icon(Icons.search, color: Colors.white);
  bool isSearching;
  var searchBarText = TextEditingController();
  List<Recipe> recipesFound = [];

  RecipePageState(this.user, this.recipe, this.diet, this.nutrition) {
    controller = RecipePageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        appBar: AppBar(
          title: appBarTitle,
          actions: <Widget>[
            IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = Icon(Icons.close);
                    this.appBarTitle = TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          hintText: "Search...",
                          hintStyle: TextStyle(color: Colors.white)),
                      controller: searchBarText,
                    );
                    isSearching = true;
                  } else {
                    controller.search();
                    isSearching = false;
                    this.actionIcon = Icon(Icons.search);
                    this.appBarTitle = Text("Recipes");
                  }
                });
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: recipesFound.length,
          itemBuilder: (context, int index) {
            return Container(
              child: ListTile(
                leading: CachedNetworkImage(
                  imageUrl: recipesFound[index].imageURL,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error_outline),
                ),
                title: Text("${recipesFound[index].name}"),
                subtitle: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //children: recipesFound[index].dietInfo.getIcons(),
                ),
                onTap: () => controller.onTap(index),
              ),
            );
          },
        ));
  }
}
