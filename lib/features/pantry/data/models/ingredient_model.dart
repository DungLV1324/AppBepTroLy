import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class IngredientModel extends Equatable {
  final String id;
  final String name;
  final double quantity;
  final String unit;
  final DateTime expiryDate; // Hạn sử dụng
  final DateTime entryDate;  // Ngày nhập kho (để sắp xếp)

  const IngredientModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.expiryDate,
    required this.entryDate,
  });

  factory IngredientModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) throw Exception("Data is null");

    return IngredientModel(
      id: doc.id,
      name: data['name'] ?? 'Nguyên liệu lạ',
      quantity: (data['quantity'] as num?)?.toDouble() ?? 0.0,
      unit: data['unit'] ?? 'g',
      expiryDate: (data['expiryDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      entryDate: (data['entryDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'expiryDate': Timestamp.fromDate(expiryDate),
      'entryDate': Timestamp.fromDate(entryDate),
    };
  }

  IngredientModel copyWith({
    String? name,
    double? quantity,
    String? unit,
    DateTime? expiryDate,
    DateTime? entryDate,
  }) {
    return IngredientModel(
      id: id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      expiryDate: expiryDate ?? this.expiryDate,
      entryDate: entryDate ?? this.entryDate,
    );
  }

  @override
  List<Object?> get props => [id, name, quantity, unit, expiryDate, entryDate];
}