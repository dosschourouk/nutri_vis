import 'package:flutter/material.dart';
import '../models/aliment_model.dart';

class NutritionProvider with ChangeNotifier {
  final List<AlimentBio> _selection = [];

  List<AlimentBio> get selection => _selection;

  void ajouterAliment(AlimentBio aliment) {
    _selection.add(aliment);
    notifyListeners(); // Rafraîchit l'UI
  }

  double get totalCalories => _selection.fold(0, (sum, item) => sum + item.calories);
}