import 'package:flutter/material.dart'; // Importez la page suivante ici
import 'package:tictatoe/Pages/Bord.dart';
import 'package:tictatoe/component/AppBar.dart';
import 'package:tictatoe/component/BottomAppBar.dart';
import 'package:tictatoe/function/ChangePage.dart';

class DifficultySelectionPage extends StatelessWidget {
  final int mode;
  final String player1Name;
  final String player2Name;
  final Color player1Color;
  final Color player2Color;

  const DifficultySelectionPage({
    super.key,
    required this.mode,
    required this.player1Name,
    required this.player2Name,
    required this.player1Color,
    required this.player2Color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RoundedAppBar(
        title: "Niveau de difficulté",
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
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
                    _navigateToGameBoardPage(context, 3);
                  }),
                  _buildDifficultyButton(context, '4x4', 4, () {
                    _navigateToGameBoardPage(context, 4);
                  }),
                  _buildDifficultyButton(context, '5x5', 5, () {
                    _navigateToGameBoardPage(context, 5);
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

  void _navigateToGameBoardPage(BuildContext context, int boardSize) {
    navigateToPage(
      context,
      TicTacToeBoard(
        mode: mode,
        player1Name: player1Name,
        player2Name: player2Name,
        player1Color: player1Color,
        player2Color: player2Color,
        boardSize: boardSize,
      ),
    );
  }
}
