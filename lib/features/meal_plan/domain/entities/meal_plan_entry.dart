class MealPlanEntryEntity {
  final String id;
  final DateTime date;
  final String mealType;
  final int recipeId; // ID Spoonacular
  final String recipeTitle;
  final String recipeImage;

  MealPlanEntryEntity({
    required this.id,
    required this.date,
    required this.mealType,
    required this.recipeId,
    required this.recipeTitle,
    required this.recipeImage,
  });
}