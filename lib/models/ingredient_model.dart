import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class IngredientModel extends Equatable {
  final String id;
  final String name;
  final double quantity;
  final String unit;
  final DateTime expiryDate;

  const IngredientModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.expiryDate,
  });

  factory IngredientModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) throw Exception("Data is null");

    return IngredientModel(
      id: doc.id,
      name: data['name'] ?? '',
      quantity: (data['quantity'] as num?)?.toDouble() ?? 0.0,
      unit: data['unit'] ?? 'g',
      // Chuyển đổi Timestamp của Firebase sang DateTime của Dart
      expiryDate: (data['expiryDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'expiryDate': Timestamp.fromDate(expiryDate),
    };
  }

  @override
  List<Object?> get props => [id, name, quantity, unit, expiryDate];
}