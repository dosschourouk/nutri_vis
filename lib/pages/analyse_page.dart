import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/nutrition_provider.dart';

class AnalysePage extends StatelessWidget {
  const AnalysePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Accès aux données du panier de calories
    final nutritionProvider = Provider.of<NutritionProvider>(context);
    final selection = nutritionProvider.selection;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Analyse Nutritionnelle"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Section Résumé (Atelier 7)
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.green),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Calories :", 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("${nutritionProvider.totalCalories.toStringAsFixed(1)} kcal",
                  style: const TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          const Divider(),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Historique de la journée", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),

          // Liste des aliments sélectionnés
          Expanded(
            child: selection.isEmpty
                ? const Center(child: Text("Aucun aliment ajouté pour le moment."))
                : ListView.builder(
                    itemCount: selection.length,
                    itemBuilder: (context, index) {
                      final item = selection[index];
                      return ListTile(
                        leading: const Icon(Icons.check_circle, color: Colors.green),
                        title: Text(item.nom),
                        subtitle: Text("${item.calories} kcal"),
                        trailing: const Icon(Icons.eco, color: Colors.lightGreen),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}