import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

// Imports de vos pages et services
import 'providers/nutrition_provider.dart';
import 'pages/home_page.dart';
import 'pages/list_aliment_page.dart'; 
import 'pages/detail_aliment_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/analyse_page.dart';
import 'pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialisation de Firebase avec vos clés (Méthode la plus fiable pour Flutter Web)
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAoQLsOD2_LAHK_HHr2WOTI_UG0Zpk1xVI",
        authDomain: "nutrivis-c601b.firebaseapp.com",
        databaseURL: "https://nutrivis-c601b-default-rtdb.firebaseio.com",
        projectId: "nutrivis-c601b",
        storageBucket: "nutrivis-c601b.firebasestorage.app",
        messagingSenderId: "894457547113",
        appId: "1:894457547113:web:d8dcb776023c9aa544d5f8",
      ),
    );
    print("Firebase connecté !");
  } catch (e) {
    print("Erreur d'initialisation : $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NutritionProvider()),
      ],
      child: const NutriVisApp(),
    ),
  );
}

class NutriVisApp extends StatelessWidget {
  const NutriVisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nutri_Vis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      // L'app commence par le Login
      initialRoute: '/login', 
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/': (context) => const HomePage(),
        '/liste': (context) => ListAlimentsPage(), 
        '/detail': (context) => const DetailAlimentPage(),
        '/analyse': (context) => const AnalysePage(),
        '/profil': (context) => const ProfilePage(),
      },
    );
  }
}