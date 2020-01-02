

import 'package:flutter/material.dart';

class Diet {
  bool vegetarian, vegan, glutenFree, dairyFree;

  Diet({
    this.vegan,
    this.vegetarian,
    this.glutenFree,
    this.dairyFree,    
  });



  // List<Widget> getIcons() {
  //    var supportedDietOptions = {
  //      VEGAN: this.vegan, 
  //      VEGATARIAN: this.vegatarian, 
  //      GLUTEN_FREE: this.glutenFree, 
  //      DAIRY_FREE: this.dairyFree,
  //    };
  //   supportedDietOptions.removeWhere((key, value) => !value);
  //   List<List> results = [];
  //   List<Widget> row = [];
  //   supportedDietOptions.forEach((key, value) {
  //     if (row.length == 2) {
  //       results.add(row);
  //       row.clear();
  //     }
  //     row.add(Text("$key ✔ "));
  //   });
  //   results.add(row);
    
  //   return _splitRows(results);
  // }

  // List<Widget> _splitRows(List<List> rows) {
  //   List<Widget> results = [];
  //   rows.forEach((row) {
  //     //print(row);
  //     results.add(Row(
  //       children: row,
  //     ));
  //   });
  //   return results;
  // }

  static const VEGAN = "Vegan";
  static const VEGeTARIAN = "Vegetarian";
  static const GLUTEN_FREE = "Gluten-free";
  static const DAIRY_FREE = "Dairy-free";
}