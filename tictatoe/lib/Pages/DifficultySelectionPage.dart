import 'package:flutter/material.dart';// Importez la page suivante ici
import 'package:tictatoe/Pages/PlayerSelection.dart';
import 'package:tictatoe/component/AppBar.dart';
import 'package:tictatoe/component/BottomAppBar.dart';
import 'package:tictatoe/function/ChangePage.dart';

class DifficultySelectionPage extends StatelessWidget {
  final int mode;

  const DifficultySelectionPage({Key? key, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RoundedAppBar(
        title: "Niveau de difficulté",
      ),
      bottomNavigationBar: CustomBottomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildAnimatedImage(),
            Container(
              padding: const EdgeInsets.all(30),
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDifficultyButton(context, '3x3', 3, () {
                    _navigateToColorSelectionPage(context, 3);
                  }),
                  _buildDifficultyButton(context, '4x4', 4, () {
                    _navigateToColorSelectionPage(context, 4);
                  }),
                  _buildDifficultyButton(context, '5x5', 5, () {
                    _navigateToColorSelectionPage(context, 5);
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
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      width: 150,
      height: 150,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('images/ModeImg.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(
    BuildContext context,
    String difficulty,
    int size,
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
            Text(
              difficulty,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour naviguer vers la page de sélection des couleurs des joueurs avec la taille du plateau
  void _navigateToColorSelectionPage(BuildContext context, int boardSize) {
    navigateToPage(context, ColorSelectionPage(mode: mode, boardSize: boardSize));
  }
}
