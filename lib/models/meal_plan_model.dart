import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MealPlanModel extends Equatable {
  final String id;
  final String recipeTitle; // Lưu cứng tên món
  final String mealType; // 'Sáng', 'Trưa', 'Tối'
  final DateTime date;
  final int recipeId; // ID tham chiếu Spoonacular

  const MealPlanModel({
    required this.id,
    required this.recipeTitle,
    required this.mealType,
    required this.date,
    required this.recipeId,
  });

  factory MealPlanModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return MealPlanModel(
      id: doc.id,
      recipeTitle: data?['recipeTitle'] ?? '',
      mealType: data?['mealType'] ?? 'Tối',
      date: (data?['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      recipeId: (data?['recipeId'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recipeTitle': recipeTitle,
      'mealType': mealType,
      'date': Timestamp.fromDate(date),
      'recipeId': recipeId,
    };
  }

  @override
  List<Object?> get props => [id, recipeTitle, mealType, date, recipeId];
}