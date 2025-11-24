import 'package:equatable/equatable.dart';

class RecipeIngredientModel extends Equatable {
  final String name;
  final double amount;
  final String unit;
  final int? spoonacularId;
  final String? image;

  const RecipeIngredientModel({
    required this.name,
    required this.amount,
    required this.unit,
    this.spoonacularId,
    this.image,
  });

  factory RecipeIngredientModel.fromJson(Map<String, dynamic> json) {
    return RecipeIngredientModel(
      name: json['nameClean'] as String? ?? json['name'] as String? ?? 'Nguyên liệu',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      unit: json['unit'] as String? ?? '',
      spoonacularId: json['id'] as int?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'unit': unit,
      'spoonacularId': spoonacularId,
      'image': image,
    };
  }

  @override
  List<Object?> get props => [name, amount, unit, spoonacularId, image];
}