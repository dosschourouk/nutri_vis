class AlimentBio {
  final String id;
  final String nom;
  final String imageUrl;
  final double calories;
  final String descriptionBio;

  AlimentBio({
    required this.id, 
    required this.nom, 
    required this.imageUrl, 
    required this.calories,
    required this.descriptionBio,
  });

  factory AlimentBio.fromMap(Map<String, dynamic> map, String documentId) {
    return AlimentBio(
      id: documentId,
      nom: map['nom'] ?? 'Nom inconnu',
      imageUrl: map['imageUrl'] ?? '',
      // Conversion sécurisée : accepte String, int ou double venant de Firebase
      calories: map['calories'] is num 
          ? (map['calories'] as num).toDouble() 
          : double.tryParse(map['calories']?.toString() ?? '0') ?? 0.0,
      descriptionBio: map['descriptionBio'] ?? 'Pas de description',
    );
  }
}