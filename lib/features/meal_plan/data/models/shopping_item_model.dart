import '../../domain/entities/shopping_item.dart';

class ShoppingItemModel extends ShoppingItemEntity {
  ShoppingItemModel({
    required super.id,
    required super.name,
    required super.isBought,
    required super.quantity,
    required super.unit,
    super.sourceRecipeId,
  });

  factory ShoppingItemModel.fromJson(Map<String, dynamic> json, String id) {
    return ShoppingItemModel(
      id: id,
      name: json['name'] as String,
      isBought: json['isBought'] as bool,
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String,
      sourceRecipeId: json['sourceRecipeId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isBought': isBought,
      'quantity': quantity,
      'unit': unit,
      'sourceRecipeId': sourceRecipeId,
    };
  }
}