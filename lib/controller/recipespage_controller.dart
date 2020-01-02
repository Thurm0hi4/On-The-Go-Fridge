import 'package:flutter/material.dart';
import 'package:onthegofridge/model/recipe.dart';
import 'package:onthegofridge/view/recipesdetailspage.dart';
import 'package:onthegofridge/view/recipespage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class RecipePageController {
  RecipePageState state;

  RecipePageController(this.state);

  Future<void> search() async {
    String query = state.searchBarText.text;
    print("Search Query: $query");
    String url = buildComplexSearchQuery(query);
    var request = await fetchGet(url);
    List results = json.decode(request.body)['results'];
    //print(results.length.toString());
    state.recipesFound.clear();
    results.forEach((recipe) {
      state.recipesFound.add(Recipe.parseRequest(recipe));
    });
    // ----------- test case ------------ //
    // state.recipesFound.add(Recipe(
    //   id: 15097,
    //   imageURL: "https://spoonacular.com/recipeImages/15097-312x231.jpg",
    //   name: "whole-grain spaghetti with garlicky kale and tomatoes",
    //   nutritionInfo: Nutrition(
    //     calories: 437.075,
    //     carbs: 58.5851,
    //     fat: 17.1951,
    //     protein: 18.5428,
    //   ),
    //   dietInfo: Diet(
    //     dairyFree: true,
    //     glutenFree: true,
    //     vegan: true,
    //     vegatarian: true,
    //   ),
    // ));
    state.stateChanged(() {});
  }

  String buildComplexSearchQuery(String query) {
    String url = "https://api.spoonacular.com/recipes/complexSearch";
    String apiKey = "dee4ce4a01de4cf885fe39c0f8612b88";
    List variables = [
      "query=$query",
      "apiKey=$apiKey",
      "addRecipeInformation=true",
      "minCalories=1",
      "minFat=1",
      "minProtein=1",
      "minCarbs=1",
    ];
    String getValue = variables.join("&");
    String finalUrl = "$url?$getValue";
    print("Query URL: $finalUrl");
    return finalUrl;
  }

  Future<http.Response> fetchGet(String url) {
    return http.get(url);
  }

  void onTap(int index){
    Navigator.push(state.context, MaterialPageRoute(
          builder: (context) => RecipeDetailsPage(state.recipesFound[index]),
        ));
  }
}
