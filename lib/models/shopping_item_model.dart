import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ShoppingListItemModel extends Equatable {
  final String id;
  final String name;
  final bool isBought;
  final String notes;
  final int? recipeIdSource; // Mua cho món gì? (Optional)

  const ShoppingListItemModel({
    required this.id,
    required this.name,
    this.isBought = false,
    this.notes = '',
    this.recipeIdSource,
  });

  factory ShoppingListItemModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return ShoppingListItemModel(
      id: doc.id,
      name: data?['name'] ?? '',
      isBought: data?['isBought'] ?? false,
      notes: data?['notes'] ?? '',
      recipeIdSource: (data?['recipeIdSource'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isBought': isBought,
      'notes': notes,
      'recipeIdSource': recipeIdSource,
    };
  }

  @override
  List<Object?> get props => [id, name, isBought, notes, recipeIdSource];
}