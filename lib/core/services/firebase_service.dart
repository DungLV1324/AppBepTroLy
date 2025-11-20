import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // CREATE - Thêm document
  Future<String> add(String collection, Map<String, dynamic> data) async {
    final doc = await _firestore.collection(collection).add(data);
    return doc.id;
  }

  // READ - Lấy documents của user
  Future<List<Map<String, dynamic>>> getByUser(
      String collection,
      String userId,
      ) async {
    final snapshot = await _firestore
        .collection(collection)
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((doc) => {'id': doc.id, ...doc.data()})
        .toList();
  }

  // UPDATE - Cập nhật document
  Future<void> update(
      String collection,
      String docId,
      Map<String, dynamic> data,
      ) async {
    await _firestore.collection(collection).doc(docId).update(data);
  }

  // DELETE - Xóa document
  Future<void> delete(String collection, String docId) async {
    await _firestore.collection(collection).doc(docId).delete();
  }

  // STREAM - Lắng nghe realtime
  Stream<List<Map<String, dynamic>>> stream(
      String collection,
      String userId,
      ) {
    return _firestore
        .collection(collection)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => {'id': doc.id, ...doc.data()})
        .toList());
  }
}