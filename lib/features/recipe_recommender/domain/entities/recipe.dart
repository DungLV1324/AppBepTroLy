class RecipeEntity {
  final int id;
  final String title;
  final String? image;
  final int? readyInMinutes;
  final String? instructions;
  final int usedIngredientCount;
  final int missedIngredientCount;

  RecipeEntity({
    required this.id,
    required this.title,
    this.image,
    this.readyInMinutes,
    this.instructions,
    this.usedIngredientCount = 0,
    this.missedIngredientCount = 0,
  });
}