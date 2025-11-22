class MealDetail {
  final String id;
  final String name;
  final String instructions;
  final String thumb;
  final String youtube;
  final List<String> ingredients;

  MealDetail({
    required this.id,
    required this.name,
    required this.instructions,
    required this.thumb,
    required this.youtube,
    required this.ingredients,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredients.add("$ingredient - $measure");
      }
    }

    return MealDetail(
      id: json['idMeal'],
      name: json['strMeal'],
      instructions: json['strInstructions'],
      thumb: json['strMealThumb'],
      youtube: json['strYoutube'] ?? '',
      ingredients: ingredients,
    );
  }
}
