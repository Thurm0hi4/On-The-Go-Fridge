class Nutrition {
  double calories, protein, fat, carbs;

  Nutrition({
    this.calories,
    this.protein,
    this.fat,
    this.carbs,
  });

  static Nutrition parseRequest(var requestBody) {
    double _findValue(String key, var requestBody) => requestBody
        .firstWhere((nutritionData) => nutritionData['title'] == key)['amount'];
    return Nutrition(
      calories: _findValue("Calories", requestBody),
      protein: _findValue("Protein", requestBody),
      fat: _findValue("Fat", requestBody),
      carbs: _findValue("Carbohydrates", requestBody),
    );
  }
}
