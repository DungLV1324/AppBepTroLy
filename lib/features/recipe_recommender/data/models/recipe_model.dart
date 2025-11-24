import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'recipe_ingredient_model.dart';

class RecipeModel extends Equatable {
  final int id;
  final String title;
  final String? image;
  final int? cookingTimeMinutes;
  final String? instructions;

  final int usedIngredientCount;
  final int missedIngredientCount;

  final List<RecipeIngredientModel>? ingredients;

  final DateTime? cachedAt;

  const RecipeModel({
    required this.id,
    required this.title,
    this.image,
    this.cookingTimeMinutes,
    this.instructions,
    this.usedIngredientCount = 0,
    this.missedIngredientCount = 0,
    this.ingredients,
    this.cachedAt,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {

    List<RecipeIngredientModel> parsedIngredients = [];

    if (json['extendedIngredients'] != null) {
      parsedIngredients = (json['extendedIngredients'] as List)
          .map((i) => RecipeIngredientModel.fromJson(i))
          .toList();
    } else {
      final used = (json['usedIngredients'] as List? ?? []);
      final missed = (json['missedIngredients'] as List? ?? []);
      parsedIngredients = [...used, ...missed]
          .map((i) => RecipeIngredientModel.fromJson(i))
          .toList();
    }

    return RecipeModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? 'Món chưa tên',
      image: json['image'] as String?,

      cookingTimeMinutes: json['readyInMinutes'] as int? ?? 0,

      instructions: json['instructions'] as String? ?? '',

      usedIngredientCount: json['usedIngredientCount'] as int? ?? 0,
      missedIngredientCount: json['missedIngredientCount'] as int? ?? 0,

      ingredients: parsedIngredients,
      cachedAt: DateTime.now(),
    );
  }

  factory RecipeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RecipeModel(
      id: data['id'] as int,
      title: data['title'] ?? '',
      image: data['image'],
      cookingTimeMinutes: data['cookingTimeMinutes'],
      instructions: data['instructions'],
      usedIngredientCount: 0,
      missedIngredientCount: 0,
      cachedAt: (data['cachedAt'] as Timestamp?)?.toDate(),
    );
  }

  @override
  List<Object?> get props => [id, title, image, cookingTimeMinutes, usedIngredientCount, missedIngredientCount];
}