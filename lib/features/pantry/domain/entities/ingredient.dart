class Ingredient {
  final String id;
  final String name;
  final double quantity;
  final String unit;
  final DateTime expirationDate; // FR1.2: Hạn sử dụng
  final DateTime entryDate; // Ngày nhập kho

  Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.expirationDate,
    required this.entryDate,
  });

  // Phương thức copyWith giúp cập nhật đối tượng (quan trọng cho FR1.3)
  Ingredient copyWith({
    String? name,
    double? quantity,
    String? unit,
    DateTime? expirationDate,
  }) {
    return Ingredient(
      id: id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      expirationDate: expirationDate ?? this.expirationDate,
      entryDate: entryDate,
    );
  }
}