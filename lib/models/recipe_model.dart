import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class RecipeModel extends Equatable {
  final int id; // ID Spoonacular (VD: 73420)
  final String title;
  final String? imageUrl;
  final int readyInMinutes;
  final String? instructions; // Hướng dẫn nấu
  final DateTime? cachedAt; // Thời điểm lưu cache

  const RecipeModel({
    required this.id,
    required this.title,
    this.imageUrl,
    this.readyInMinutes = 0,
    this.instructions,
    this.cachedAt,
  });

  // 1. Tạo từ JSON API (Spoonacular)
  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? 'Món ăn chưa đặt tên',
      imageUrl: json['image'] as String?,
      readyInMinutes: json['readyInMinutes'] as int? ?? 0,
      instructions: json['instructions'] as String?,
      cachedAt: DateTime.now(),
    );
  }

  // 2. Tạo từ Firestore (Cache)
  factory RecipeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RecipeModel(
      id: data['id'] as int,
      title: data['title'] ?? '',
      imageUrl: data['image'],
      readyInMinutes: data['readyInMinutes'] ?? 0,
      instructions: data['instructions'],
      cachedAt: (data['cachedAt'] as Timestamp?)?.toDate(),
    );
  }

  // 3. Chuyển sang Map (Để lưu Cache)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': imageUrl,
      'readyInMinutes': readyInMinutes,
      'instructions': instructions,
      'cachedAt': Timestamp.fromDate(DateTime.now()),
    };
  }

  @override
  List<Object?> get props => [id, title, imageUrl, readyInMinutes, instructions];
}