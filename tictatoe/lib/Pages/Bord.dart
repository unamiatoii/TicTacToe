import 'dart:math'; // Importez cette bibliothèque pour générer des nombres aléatoires

import 'package:flutter/material.dart';
import 'package:tictatoe/component/AppBar.dart';
import 'package:tictatoe/function/Logic.dart'; // Importez le fichier contenant la logique du jeu

class TicTacToeBoard extends StatefulWidget {
  final String player1Name;
  final String player2Name;
  final Color player1Color;
  final Color player2Color;
  final int difficultyLevel; // Nouveau paramètre pour le niveau de difficulté
  final int mode; // Nouveau paramètre pour le mode de jeu

  const TicTacToeBoard({
    Key? key,
    required this.player1Name,
    required this.player2Name,
    required this.player1Color,
    required this.player2Color,
    required this.difficultyLevel,
    required this.mode, // Ajout du mode de jeu
  });

  @override
  _TicTacToeBoardState createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  late GameLogic gameLogic;

  @override
  void initState() {
    super.initState();
    // Initialise le plateau de jeu en fonction du niveau de difficulté
    gameLogic = GameLogic(gridSize: widget.difficultyLevel);
    // Si le mode est 2 (contre l'ordinateur) et c'est au tour de l'ordinateur, joue un coup
    if (widget.mode == 2 && !gameLogic.player1Turn) {
      _playComputerMove();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RoundedAppBar(
        title: "THE MORPION GAME",
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(
              20.0,
            ), // Bordures arrondies du grand carré
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // Position de l'ombre
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.difficultyLevel,
              (row) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.difficultyLevel,
                  (col) => GestureDetector(
                    onTap: () {
                      _playMove(row, col);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: gameLogic.board[row][col] == 'X'
                            ? widget.player1Color
                            : gameLogic.board[row][col] == 'O'
                                ? widget.player2Color
                                : Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Text(
                          gameLogic.board[row][col],
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _playMove(int row, int col) {
    setState(() {
      if (gameLogic.playMove(row, col)) {
        if (gameLogic.checkForWinner(row, col)) {
          _showGameOverDialog(
              gameLogic.player1Turn ? widget.player2Name : widget.player1Name);
        } else if (gameLogic.checkForDraw()) {
          _showGameOverDialog('Match nul');
        } else if (widget.mode == 2 && !gameLogic.player1Turn) {
          _playComputerMove(); // Si le mode est 2 (contre l'ordinateur) et c'est au tour de l'ordinateur, joue un coup
        }
      }
    });
  }

  void _playComputerMove() {
    // Attendez un bref délai pour l'animation avant que l'ordinateur ne joue
    Future.delayed(const Duration(milliseconds: 500), () {
      final Random random = Random();
      int randomRow, randomCol;
      do {
        randomRow = random.nextInt(widget.difficultyLevel);
        randomCol = random.nextInt(widget.difficultyLevel);
      } while (gameLogic.board[randomRow][randomCol] != ' ');
      _playMove(randomRow, randomCol);
    });
  }

  void _showGameOverDialog(String winner) {
    String title = winner == 'Match nul' ? 'Match nul' : 'And the winner is';
    IconData icon = winner == 'Match nul'
        ? Icons.sentiment_neutral
        : Icons.sentiment_satisfied;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(title),
            ],
          ),
          content: Text('$winner !'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                gameLogic.initializeBoard();
              },
              child: const Row(
                children: [
                  Icon(Icons.refresh), // Icône de rafraîchissement
                  SizedBox(width: 4),
                  Text(
                    'k',
                    style: TextStyle(fontFamily: "GessWho"),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
