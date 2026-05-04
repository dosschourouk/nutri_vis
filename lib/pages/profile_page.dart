import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Contrôleurs pour les champs de saisie
  final TextEditingController _nameController = TextEditingController(text: "Utilisateur Bio");
  final TextEditingController _emailController = TextEditingController(text: "user@nutrivis.com");
  final TextEditingController _imageController = TextEditingController(text: "https://www.w3schools.com/howto/img_avatar.png");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modifier le Profil"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Aperçu de la photo actuelle
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.green.shade100,
              backgroundImage: NetworkImage(_imageController.text),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18,
                      child: Icon(Icons.camera_alt, color: Colors.green, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            
            // Champ Nom
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nom complet",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Champ Email
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Champ URL Image
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(
                labelText: "URL de la photo de profil",
                prefixIcon: Icon(Icons.link),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() {}), // Pour mettre à jour l'aperçu
            ),
            const SizedBox(height: 40),

            // Bouton Enregistrer
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Ici, tu pourrais plus tard enregistrer dans Firebase
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profil mis à jour !"), backgroundColor: Colors.green),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("ENREGISTRER", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}