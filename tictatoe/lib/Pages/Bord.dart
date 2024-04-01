import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tictatoe/component/AppBar.dart';
import 'package:tictatoe/component/BottomAppBar.dart';
import 'package:tictatoe/function/Logic.dart';

class TicTacToeBoard extends StatefulWidget {
  final int mode;
  final String player1Name;
  final String player2Name;
  final Color player1Color;
  final Color player2Color;
  final int boardSize;

  const TicTacToeBoard({
    Key? key, // Ajout de la clé pour le widget
    required this.mode,
    required this.player1Name,
    required this.player2Name,
    required this.player1Color,
    required this.player2Color,
    required this.boardSize,
  }) : super(key: key); // Utilisation de la clé fournie

  @override
  _TicTacToeBoardState createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  late GameLogic gameLogic;

  @override
  void initState() {
    super.initState();
    gameLogic = GameLogic(gridSize: widget.boardSize);
    if (widget.mode == 2 && !gameLogic.player1Turn) {
      _playComputerMove();
    }
  }

  @override
  Widget build(BuildContext context) {
    double cellSize = 100.0; // Taille par défaut des cases
    if (widget.boardSize == 4) {
      cellSize = 80.0; // Réduire la taille des cases pour 4x4
    } else if (widget.boardSize == 5) {
      cellSize = 60.0; // Réduire encore plus la taille pour 5x5
    }

    return Scaffold(
      bottomNavigationBar:  CustomBottomAppBar(),
      appBar: const RoundedAppBar(
        title: "Tic Tac Toe",
      ),
      body: Center(
        child: Material(
          elevation: 3, // Définir l'élévation ici
          borderRadius: BorderRadius.circular(
              20.0), // Assurez-vous de définir le même rayon de bordure que dans le BoxDecoration
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.boardSize,
                (row) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.boardSize,
                    (col) => GestureDetector(
                      onTap: () {
                        _playMove(row, col);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: cellSize,
                        height: cellSize,
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
          _playComputerMove();
        }
      }
    });
  }

  void _playComputerMove() {
    // Définir la durée de jeu de l'ordinateur
    const computerMoveDuration = Duration(milliseconds: 500);

    // Attendre la durée spécifiée avant de jouer le coup de l'ordinateur
    Future.delayed(computerMoveDuration, () {
      final Random random = Random();
      int randomRow, randomCol;
      do {
        randomRow = random.nextInt(widget.boardSize);
        randomCol = random.nextInt(widget.boardSize);
      } while (gameLogic.board[randomRow][randomCol] != '');

      // Imprimer le mouvement de l'ordinateur dans la console
      print('L\'ordinateur a joué au : ($randomRow, $randomCol)');

      // Appeler la méthode _playMove à l'intérieur de la fonction anonyme
      _playMove(randomRow, randomCol);
    });
  }

  void _showGameOverDialog(String winner) {
    String title = winner == 'Match nul' ? 'Match nul' : 'Le vainqueur est...';
    IconData icon = winner == 'Match nul'
        ? Icons.sentiment_neutral
        : Icons.sentiment_satisfied;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Row(
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.green,
              ),
              const SizedBox(width: 8),
              Text(title),
            ],
          ),
          content: Text(
            '$winner !',
            textAlign: TextAlign.right, // Aligner le texte à gauche
            style: TextStyle(fontSize: 28, color: Colors.green),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                gameLogic.endGame(
                  winner,
                  widget.player1Name,
                  widget.player2Name,
                );

                // Afficher les données dans la console
                print('Winner: $winner');
                print('Player 1: ${widget.player1Name}');
                print('Player 2: ${widget.player2Name}');

                gameLogic.initializeBoard(); // Réinitialiser le plateau de jeu
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.refresh,
                    size: 25,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  SizedBox(width: 4),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
