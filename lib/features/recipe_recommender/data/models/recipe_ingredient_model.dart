import '../../domain/entities/recipe_ingredient.dart';

class RecipeIngredientModel extends RecipeIngredientEntity {
  RecipeIngredientModel({
    required super.name,
    required super.quantity,
    required super.unit,
    super.spoonacularId,
  });

  // Factory Method: Ánh xạ từ Cache Firestore (Giả định)
  factory RecipeIngredientModel.fromJson(Map<String, dynamic> json) {
    return RecipeIngredientModel(
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String,
      spoonacularId: json['spoonacularId'] as int?,
    );
  }

  // Method: Chuyển sang JSON để lưu Cache Firestore (Giả định)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'spoonacularId': spoonacularId,
    };
  }

  // Factory Method: Ánh xạ từ API Spoonacular (Cấu trúc phổ biến)
  factory RecipeIngredientModel.fromApiJson(Map<String, dynamic> json) {
    return RecipeIngredientModel(
      name: json['nameClean'] as String? ?? json['name'] as String,
      quantity: (json['amount'] as num).toDouble(),
      unit: json['unit'] as String,
      spoonacularId: json['id'] as int?,
    );
  }
}