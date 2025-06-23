import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Logique de déconnexion à ajouter
              Navigator.pop(context); // Pour revenir à l'écran de connexion
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenue sur l\'écran d\'accueil !',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Vous êtes connecté avec succès.',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la logique pour naviguer vers d'autres écrans
              },
              child: Text('Explorer'),
            ),
          ],
        ),
      ),
    );
  }
}