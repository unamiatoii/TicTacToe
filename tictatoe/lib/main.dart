import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const TicTacToe());
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 255, 255, 255);
    const textColor = Color.fromARGB(255, 28, 41, 66);
    const secondaryColor = Color.fromARGB(255, 17, 96, 89);
    const backColor = Color.fromARGB(255, 155, 205, 207);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch(backgroundColor: backColor).copyWith(
          primary: primaryColor,
          secondary: secondaryColor,
          onPrimary: textColor,
          onSecondary: textColor,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: secondaryColor,
          title: const Text(
            'Tic Tak Toe',
            style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
            textAlign: TextAlign.center,
          ),
        ),
        body: TicTacToeBoard(),
      ),
    );
  }
}

class TicTacToeBoard extends StatefulWidget {
  @override
  _TicTacToeBoardState createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  late List<List<String>> board;
  late String currentPlayer;
  late bool gameOver;

  final primaryColor = Color.fromARGB(255, 255, 255, 255);
  final textColor = Color.fromARGB(255, 28, 41, 66);
  final secondaryColor = Color.fromARGB(255, 17, 96, 89);
  final backColor = Color.fromARGB(255, 155, 205, 207);
  final xColor = Color.fromARGB(255, 160, 118, 26);
  final oColor = Color.fromARGB(255, 208, 84, 38);
  @override
  void initState() {
    super.initState();
    initializeBoard();
  }

  void initializeBoard() {
    board = List.generate(3, (_) => List.filled(3, ''));
    currentPlayer = 'X';
    gameOver = false;
  }

  void playMove(int row, int col) {
    final primaryColor = Color.fromARGB(255, 255, 255, 255);
    final textColor = Color.fromARGB(255, 28, 41, 66);
    final secondaryColor = Color.fromARGB(255, 17, 96, 89);

    //SI le jeu n'est pas terminé et que la case touché n'est pas vide
    if (!gameOver && board[row][col] == '') {
      setState(() {
        board[row][col] = currentPlayer;
        //Mise a jour de la touche

        //Verification de s'il n'ya pas de vainqueur
        if (checkForWinner(row, col)) {
          gameOver = true;
          //Si le jeu est terminer et qu'il ya un vainqueur

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: primaryColor,
                title: const Text(
                  'Game Over',
                  style: TextStyle(
                      color: Color.fromARGB(255, 32, 198, 137),
                      fontWeight: FontWeight.bold),
                ),
                content: Text('Victoire des $currentPlayer',
                    style: TextStyle(
                      fontSize: 25,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    )),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      initializeBoard();
                    },
                    child: Text(
                      'Rejouer',
                      style: TextStyle(color: secondaryColor),
                    ),
                  ),
                ],
              );
            },
          );
          //Boite de Dialogue dans le cas ou il ya une victoire
        } else if (checkForDraw()) {
          gameOver = true;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: primaryColor,
                title: const Text(
                  'Game Over',
                  style: TextStyle(
                      color: Color.fromARGB(255, 32, 198, 137),
                      fontWeight: FontWeight.bold),
                ),
                content: Text('Partie nulle',
                    style: TextStyle(
                      fontSize: 25,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    )),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      initializeBoard();
                    },
                    child: Text('Play Again'),
                  ),
                ],
              );
            },
          );
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        }
      });
    }
  }

//Verifier s'il ya un vainqueur
  bool checkForWinner(int row, int col) {
    String player = board[row][col];
    bool won = true;

    // Check row
    for (int i = 0; i < 3; i++) {
      if (board[row][i] != player) {
        won = false;
        break;
      }
    }
    if (won) return true;

    // Check column
    won = true;
    for (int i = 0; i < 3; i++) {
      if (board[i][col] != player) {
        won = false;
        break;
      }
    }
    if (won) return true;

    // Check diagonals
    if (row == col) {
      won = true;
      for (int i = 0; i < 3; i++) {
        if (board[i][i] != player) {
          won = false;
          break;
        }
      }
      if (won) return true;
    }

    if (row + col == 2) {
      won = true;
      for (int i = 0; i < 3; i++) {
        if (board[i][2 - i] != player) {
          won = false;
          break;
        }
      }
      if (won) return true;
    }

    return false;
  }

//Verifier s'il y aun null
  bool checkForDraw() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5), //Padding

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Au tour de :',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '$currentPlayer',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: oColor),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 9, //9 cases
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              int row = index ~/ 3; //3lignes
              int col = index % 3; //3 Colones
              return GestureDetector(
                onTap: () => playMove(
                    row, col), //Prends en parametre les cordonées de la cases
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 17, 96, 89)),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Center(
                    child: Text(
                      board[row][col],
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
              ); //Chaque cases
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Au tour de :',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '$currentPlayer',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: xColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
