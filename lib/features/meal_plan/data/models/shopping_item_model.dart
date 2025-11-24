class ShoppingItemModel {
  final String id;
  final String name;
  final bool isBought;
  final double quantity;
  final String unit;
  final int? sourceRecipeId;

  ShoppingItemModel({
    required this.id,
    required this.name,
    required this.isBought,
    required this.quantity,
    required this.unit,
    this.sourceRecipeId,
  });

  factory ShoppingItemModel.fromJson(Map<String, dynamic> json, String id) {
    return ShoppingItemModel(
      id: id,
      name: json['name'] as String? ?? 'Món lạ',
      isBought: json['isBought'] as bool? ?? false,
      quantity: (json['quantity'] as num?)?.toDouble() ?? 1.0,
      unit: json['unit'] as String? ?? '',
      sourceRecipeId: (json['sourceRecipeId'] as num?)?.toInt(),
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

  ShoppingItemModel copyWith({
    String? id,
    String? name,
    bool? isBought,
    double? quantity,
    String? unit,
    int? sourceRecipeId,
  }) {
    return ShoppingItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isBought: isBought ?? this.isBought,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      sourceRecipeId: sourceRecipeId ?? this.sourceRecipeId,
    );
  }
}