import './nutrition.dart';
import './diet.dart';

class Recipe {
  String name, imageURL;
  int id;
  Nutrition nutritionInfo;
  Diet dietInfo;

  Recipe({
    this.name,
    this.id,
    this.imageURL,
    this.nutritionInfo,
    this.dietInfo,
  }) {
    this.name = _formatValue(this.name);
  }

  get calories => nutritionInfo.calories;
  get fat => nutritionInfo.fat;
  get carbs => nutritionInfo.carbs;
  get protein => nutritionInfo.protein;

  get vegan => dietInfo.vegan;
  get vegetarian => dietInfo.vegetarian;
  get dairyFree => dietInfo.dairyFree;
  get glutenFree => dietInfo.glutenFree;

  static Recipe parseRequest(var requestBody) {
    //print(requestBody['vegan']);
    return Recipe(
      name: requestBody['title'],
      id: requestBody['id'],
      imageURL: requestBody['image'],
      nutritionInfo: Nutrition.parseRequest(requestBody['nutrition']),
      dietInfo: Diet(
        vegan: requestBody['vegan'],
        dairyFree: requestBody['dairyFree'],
        glutenFree: requestBody['glutenFree'],
        vegetarian: requestBody['vegetarian'],
      ),
    );
  }

  _formatValue(String value) => value
      .split(" ")
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(" ");
}
