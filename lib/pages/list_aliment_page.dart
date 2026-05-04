import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../models/aliment_model.dart';

class ListAlimentsPage extends StatefulWidget {
  @override
  State<ListAlimentsPage> createState() => _ListAlimentsPageState();
}

class _ListAlimentsPageState extends State<ListAlimentsPage> {
  final FirebaseService _fs = FirebaseService();

  // Fonction pour afficher le formulaire d'ajout
  void _afficherFormulaire() {
    final nomController = TextEditingController();
    final calController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Ajouter un aliment"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nomController, decoration: const InputDecoration(labelText: "Nom")),
            TextField(controller: calController, decoration: const InputDecoration(labelText: "Calories"), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Annuler")),
          ElevatedButton(
            onPressed: () async {
              await _fs.ajouterAliment(
                nomController.text, 
                double.parse(calController.text),
                "https://via.placeholder.com/150", // Image par défaut
                "Description bio standard"
              );
              Navigator.pop(context);
              setState(() {}); // Rafraîchir la liste
            }, 
            child: const Text("Ajouter")
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gestion des Aliments"), backgroundColor: Colors.green),
      body: FutureBuilder<List<AlimentBio>>(
        future: _fs.getAliments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final aliments = snapshot.data!;
          
          return ListView.builder(
            itemCount: aliments.length,
            itemBuilder: (context, index) {
              final aliment = aliments[index];
              return ListTile(
                title: Text(aliment.nom),
                subtitle: Text("${aliment.calories} kcal"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await _fs.supprimerAliment(aliment.id);
                    setState(() {}); // Rafraîchir la liste après suppression
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _afficherFormulaire,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}