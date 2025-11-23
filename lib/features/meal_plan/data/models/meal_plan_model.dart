import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/meal_plan_entry.dart';

class MealPlanEntryModel extends MealPlanEntryEntity {
  MealPlanEntryModel({
    required super.id,
    required super.date,
    required super.mealType,
    required super.recipeId,
    required super.recipeTitle,
    required super.recipeImage,
  });

  factory MealPlanEntryModel.fromJson(Map<String, dynamic> json, String id) {
    return MealPlanEntryModel(
      id: id,
      date: (json['date'] as Timestamp).toDate(),
      mealType: json['mealType'] as String,
      recipeId: json['recipeId'] as int,
      recipeTitle: json['recipeTitle'] as String,
      recipeImage: json['recipeImage'] as String,
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