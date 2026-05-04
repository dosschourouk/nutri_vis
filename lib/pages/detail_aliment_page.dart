import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/aliment_model.dart';
import '../providers/nutrition_provider.dart';

class DetailAlimentPage extends StatelessWidget {
  const DetailAlimentPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Récupération sécurisée de l'argument (Atelier 6)
    final aliment = ModalRoute.of(context)!.settings.arguments as AlimentBio;

    // 2. Accès au Provider (Atelier 7)
    final nutritionProvider = Provider.of<NutritionProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(aliment.nom),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image de l'aliment (Atelier 5)
            Hero(
              tag: aliment.id,
              child: Image.network(
                aliment.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                // Gestion d'erreur d'image
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 300,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ligne Nom et Calories
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          aliment.nom,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "${aliment.calories} kcal",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 40),

                  // Section Description (Analyse Bio)
                  const Text(
                    "Analyse Nutritionnelle",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    aliment.descriptionBio, // Vérifié avec le modèle précédent
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Bouton d'action (Atelier 7)
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        nutritionProvider.ajouterAliment(aliment);

                        // SnackBar (Atelier 6)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${aliment.nom} ajouté au suivi !"),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_task),
                      label: const Text(
                        "AJOUTER AU SUIVI QUOTIDIEN",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}