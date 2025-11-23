import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/recipe.dart';
// import 'recipe_ingredient_model.dart'; // Tạm thời chưa dùng đến chi tiết nguyên liệu thì comment lại cũng được

class RecipeModel extends RecipeEntity {
  final DateTime? cachedAt;

  RecipeModel({
    required super.id,
    required super.title,
    required super.image,
    required super.readyInMinutes,
    required super.instructions,
    super.usedIngredientCount,
    super.missedIngredientCount,
    this.cachedAt,
    // required super.requiredIngredients, // Tạm thời bỏ qua list chi tiết nếu chưa parse
  });

  // Factory Method: Xử lý thông minh cả từ Cache và API
  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? 'Món chưa tên',
      image: json['image'] as String?, // Cho phép null
      readyInMinutes: json['readyInMinutes'] as int? ?? 0,
      instructions: json['instructions'] as String? ?? '',

      // MAP 2 TRƯỜNG QUAN TRỌNG CHO UI HOME
      usedIngredientCount: json['usedIngredientCount'] as int? ?? 0,
      missedIngredientCount: json['missedIngredientCount'] as int? ?? 0,

      cachedAt: DateTime.now(),
    );
  }
}