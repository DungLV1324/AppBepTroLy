class ShoppingItemEntity {
  final String id;
  final String name;
  final bool isBought;
  final double quantity;
  final String unit;
  final int? sourceRecipeId; // ID từ Spoonacular (Optional)

  ShoppingItemEntity({
    required this.id,
    required this.name,
    required this.isBought,
    required this.quantity,
    required this.unit,
    this.sourceRecipeId,
  });

  // Phương thức copyWith (để toggle isBought)
  ShoppingItemEntity copyWith({bool? isBought}) {
    return ShoppingItemEntity(
      id: id,
      name: name,
      isBought: isBought ?? this.isBought,
      quantity: quantity,
      unit: unit,
      sourceRecipeId: sourceRecipeId,
    );
  }
}