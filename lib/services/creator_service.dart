import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreatorService {
  static final _db = FirebaseFirestore.instance;

  static Future<void> saveProject({
    required String type,
    required String prompt,
    String? mediaUrl,
    bool published = false,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw StateError('Usuário não autenticado.');

    await _db.collection('projects').add({
      'uid': user.uid,
      'type': type,
      'prompt': prompt,
      'mediaUrl': mediaUrl,
      'published': published,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> myProjects() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream.empty();

    return _db
        .collection('projects')
        .where('uid', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> publicFeed() {
    return _db
        .collection('projects')
        .where('published', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots();
  }
}
