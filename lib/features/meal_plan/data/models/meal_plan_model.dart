import 'package:cloud_firestore/cloud_firestore.dart';

class MealPlanModel {
  final String id;
  final DateTime date;
  final String mealType;
  final int recipeId;    // ID Spoonacular
  final String recipeTitle;
  final String recipeImage;

  MealPlanModel({
    required this.id,
    required this.date,
    required this.mealType,
    required this.recipeId,
    required this.recipeTitle,
    required this.recipeImage,
  });

  factory MealPlanModel.fromJson(Map<String, dynamic> json, String id) {
    return MealPlanModel(
      id: id,
      date: (json['date'] as Timestamp).toDate(),
      mealType: json['mealType'] as String? ?? 'dinner',
      recipeId: (json['recipeId'] as num).toInt(),
      recipeTitle: json['recipeTitle'] as String? ?? '',
      recipeImage: json['recipeImage'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': Timestamp.fromDate(date),
      'mealType': mealType,
      'recipeId': recipeId,
      'recipeTitle': recipeTitle,
      'recipeImage': recipeImage,
    };
  }
}