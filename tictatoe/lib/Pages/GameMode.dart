import 'package:flutter/material.dart'; // Importez la page suivante ici
import 'package:tictatoe/Pages/PlayerSelection.dart';
import 'package:tictatoe/component/AppBar.dart';
import 'package:tictatoe/component/BottomAppBar.dart';
import 'package:tictatoe/function/ChangePage.dart';

class GameModeSelectionPage extends StatelessWidget {
  const GameModeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RoundedAppBar(
        title: "Choix du mode",
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Image ronde avec animation
            _buildAnimatedImage(),

            Container(
              padding: const EdgeInsets.all(30),
              height: 300, // Hauteur fixe souhaitée
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Boutons pour choisir le mode de jeu
                  _buildGameModeButton(context, 'Jouer à deux', Icons.person,
                      () {
                    _navigateToDifficultySelectionPage(
                        context, 1); // Mode 1: Jouer à deux
                  }),

                  _buildGameModeButton(
                      context, 'Contre robot', Icons.laptop_mac_outlined, () {
                    _navigateToDifficultySelectionPage(
                        context, 2); // Mode 2: Contre robot
                  }),

                  _buildGameModeButton(context, 'En réseau', Icons.wifi, () {
                    _navigateToDifficultySelectionPage(
                        context, 3); // Mode 3: En réseau
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedImage() {
    return AnimatedContainer(
      duration: const Duration(seconds: 1), // Durée de l'animation
      curve: Curves.easeInOut, // Courbe d'animation
      width: 150,
      height: 150,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(
              'images/ModeImg.png'), // Chemin de l'image dans les assets
          fit: BoxFit.cover, // Ajustement de la taille de l'image
        ),
      ),
    );
  }

  Widget _buildGameModeButton(
    BuildContext context,
    String mode,
    IconData iconData,
    VoidCallback onTapFunction,
  ) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              iconData,
              size: 25,
              color: Theme.of(context).colorScheme.primary,
            ),
            Expanded(
              child: Text(
                mode,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour naviguer vers la page de sélection de la difficulté avec le mode choisi
  void _navigateToDifficultySelectionPage(BuildContext context, int mode) {
    navigateToPage(context, PlayerSelectionPage(mode: mode));
  }
}
