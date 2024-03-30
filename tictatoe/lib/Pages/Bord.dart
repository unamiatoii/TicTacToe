import 'package:flutter/material.dart';
import 'package:tictatoe/function/logic.dart'; // Importez le fichier contenant la logique du jeu

class TicTacToeBoard extends StatefulWidget {
  final String player1Name;
  final String player2Name;
  final Color player1Color;
  final Color player2Color;

  const TicTacToeBoard({
    Key? key,
    required this.player1Name,
    required this.player2Name,
    required this.player1Color,
    required this.player2Color,
  }) : super(key: key);

  @override
  _TicTacToeBoardState createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  GameLogic gameLogic = GameLogic(); // Utilisez l'instance de GameLogic

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gameLogic.player1Turn
            ? 'Tour de ${widget.player1Name}'
            : 'Tour de ${widget.player2Name}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (row) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (col) => GestureDetector(
                  onTap: () {
                    _playMove(row, col);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
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
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
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
          // Afficher le dialogue de fin de jeu
          _showGameOverDialog(
              '${gameLogic.player1Turn ? widget.player2Name : widget.player1Name}');
        } else if (gameLogic.checkForDraw()) {
          // Afficher le dialogue de match nul
          _showGameOverDialog('Match nul');
        }
      }
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
              SizedBox(width: 8),
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
              child: Row(
                children: [
                  Icon(Icons.refresh), // Icône de rafraîchissement
                  SizedBox(width: 4),
                  Text('Rejouer'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
