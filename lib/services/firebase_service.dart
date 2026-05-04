import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/aliment_model.dart';

class FirebaseService {
  final CollectionReference _alimentsRef = FirebaseFirestore.instance
      .collection('aliments');

  // LIRE
  Future<List<AlimentBio>> getAliments() async {
    try {
      QuerySnapshot snapshot = await _alimentsRef.get();
      return snapshot.docs.map((doc) {
        return AlimentBio.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  // AJOUTER (Create)
  Future<void> ajouterAliment(
    String nom,
    double calories,
    String image,
    String desc,
  ) async {
    await _alimentsRef.add({
      'nom': nom,
      'calories': calories,
      'imageUrl': image,
      'descriptionBio': desc,
    });
  }

  // SUPPRIMER (Delete)
  Future<void> supprimerAliment(String id) async {
    return await _alimentsRef.doc(id).delete();
  }
}
