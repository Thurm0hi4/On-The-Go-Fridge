import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onthegofridge/controller/recipesdetailpage_controller.dart';
import 'package:onthegofridge/model/diet.dart';
import 'package:onthegofridge/model/nutrition.dart';
import 'package:onthegofridge/model/recipe.dart';


class RecipeDetailsPage extends StatefulWidget {
  final Recipe recipe;
  
  RecipeDetailsPage(this.recipe);

  @override
  State<StatefulWidget> createState() {
    return RecipeDetailsPageState(this.recipe,);
  }
}



class RecipeDetailsPageState extends State<RecipeDetailsPage> {
  Recipe recipe;
  Diet diet;
  Nutrition nutrition;

  RecipeDetailsPageController controller;
  BuildContext context;
  var formKey = GlobalKey<FormState>();

  RecipeDetailsPageState(this.recipe, ) {
    controller = RecipeDetailsPageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Details'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: recipe.imageURL,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error_outline, size: 200),
              height: 200,
              width: 200,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name: ',
              ),
              initialValue: recipe.name,
              autocorrect: false,
              enabled: false,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Calories: ',
              ),
              initialValue: recipe.calories.toString()+ "g",
              autocorrect: false,
              enabled: false,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Protein: ',
              ),
              initialValue: recipe.protein.toString()+ "g",
              enabled: false,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Fat: ',
              ),
              initialValue: recipe.fat.toString()+ "g",
              autocorrect: false,
              enabled: false,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Carbs: ',
              ),
              initialValue: recipe.carbs.toString()+ "g",
              autocorrect: false,
              enabled: false,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Vegan: ',
              ),
              initialValue: recipe.vegan.toString(),
              autocorrect: false,
              enabled: false,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Vegetarian: ',
              ),
              initialValue: recipe.vegetarian.toString() ,
              autocorrect: false,
              enabled: false,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'DairyFree: ',
              ),
              initialValue: recipe.dairyFree.toString(),
              autocorrect: false,
              enabled: false,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'GlutenFree: ',
              ),
              initialValue: recipe.glutenFree.toString(),
              autocorrect: false,
              enabled: false,
            ),
          ],
        ),
      ),
    );
  }
}
