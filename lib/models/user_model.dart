import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String email;
  final String? displayName;

  const UserModel({
    required this.uid,
    required this.email,
    this.displayName,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      displayName: data['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': displayName,
    };
  }

  @override
  List<Object?> get props => [uid, email, displayName];
}