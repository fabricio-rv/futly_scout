import 'package:futly_scout/repositories/config/i_config_repository.dart';
import 'package:futly_scout/models/weights_template.dart';

/// Firebase implementation of IConfigRepository (COMMENTED - Ready for future integration)
class FirebaseConfigRepository implements IConfigRepository {
  // TODO: Initialize Firestore when Firebase is configured
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<List<WeightsTemplate>> getTemplates() async {
    // TODO: Query templates from Firestore
    /*
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) throw Exception('Usuário não autenticado');
    
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('templates')
        .get();
    
    return snapshot.docs
        .map((doc) => WeightsTemplate.fromJson(doc.data()))
        .toList();
    */
    throw UnimplementedError('Firebase not configured');
  }

  @override
  Future<WeightsTemplate?> getTemplateById(String id) async {
    // TODO: Get template document from Firestore
    /*
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) throw Exception('Usuário não autenticado');
    
    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('templates')
        .doc(id)
        .get();
    
    if (!doc.exists) return null;
    return WeightsTemplate.fromJson(doc.data()!);
    */
    throw UnimplementedError('Firebase not configured');
  }

  @override
  Future<void> saveTemplate(WeightsTemplate template) async {
    // TODO: Save template to Firestore
    /*
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) throw Exception('Usuário não autenticado');
    
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('templates')
        .doc(template.id)
        .set(template.toJson());
    */
    throw UnimplementedError('Firebase not configured');
  }
}
