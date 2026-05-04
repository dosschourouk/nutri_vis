import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Liste des images (Assurez-vous que l'extension .jpg est la bonne)
  final List<String> imagesSante = const [
    'assets/img/image1.jpg',
    'assets/img/image2.jpg',
    'assets/img/image3.jpg',
    'assets/img/dna.jpg',
    'assets/img/nutrition.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nutri_Vis"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      // --- MENU LATÉRAL (DRAWER) ---
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://www.w3schools.com/howto/img_avatar.png"),
              ),
              accountName: Text(
                "Utilisateur Bio",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: Text("user@nutrivis.com"),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.green),
              title: const Text("Mon Profil"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profil');
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics, color: Colors.green),
              title: const Text("Mes Analyses"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/analyse');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Déconnexion"),
              onTap: () => Navigator.pushReplacementNamed(context, '/login'),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 15),
          
          // --- CAROUSEL AVEC DIAGNOSTIC D'ERREUR INTÉGRÉ ---
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true, 
              height: 220,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
            ),
            items: imagesSante.map((path) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  path, 
                  fit: BoxFit.cover, 
                  width: double.infinity,
                  // --- BLOC DE TEST/RECTIFICATION ---
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, color: Colors.red, size: 40),
                            const SizedBox(height: 10),
                            Text(
                              "ERREUR :\nLe fichier $path\nest introuvable.",
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),

          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Text(
              "Analyse Bio-informatique", 
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          // Bouton central Explorer
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/liste'),
            icon: const Icon(Icons.search),
            label: const Text("Explorer les Nutriments"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.green,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/analyse');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: "Analyse"),
        ],
      ),
    );
  }
}