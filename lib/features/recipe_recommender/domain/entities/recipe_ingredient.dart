class RecipeIngredientEntity {
  final String name;
  final double quantity;
  final String unit;
  final int? spoonacularId; // ID Nguyên liệu từ API

  RecipeIngredientEntity({
    required this.name,
    required this.quantity,
    required this.unit,
    this.spoonacularId,
  });
}