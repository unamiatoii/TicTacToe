import 'package:flutter/material.dart';
import 'package:tictatoe/Pages/playerSelection.dart';

void main() {
  runApp(const TicTacToe());
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF137C8B), // #137C8B
        hintColor: const Color(0xFF709CA7), // #709CA7
        colorScheme:const  ColorScheme(
          background: Color(0xFFB8CBD0), // #B8CBD0
          surface: Color(0xFFB8CBD0), // #B8CBD0
          onBackground: Color(0xFF7A90A4), // #7A90A4
          onSurface: Color(0xFF344D59), // #344D59
          brightness: Brightness.light,
          primary: Color(0xFF137C8B),
          onPrimary: Colors.white,
          secondary: Color(0xFF709CA7),
          onSecondary: Colors.white,
          error: Color(0xFFEF5350),
          onError: Colors.white,
        ),
      ),
      home: const ColorSelectionPage(),
    );
  }
}

// class ColorSelectionWidget extends StatelessWidget {
//   final Color selectedColor;
//   final ValueChanged<Color> onColorSelected;

//   const ColorSelectionWidget({
//     super.key,
//     required this.selectedColor,
//     required this.onColorSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         for (Color color in [
//           Colors.red,
//           Colors.green,
//           Colors.blue,
//           Colors.yellow,
//           Colors.orange,
//           Colors.purple,
//         ])
//           GestureDetector(
//             onTap: () {
//               onColorSelected(color);
//             },
//             child: Container(
//               width: 40,
//               height: 40,
//               margin: const EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 color: color,
//                 border: Border.all(
//                   color: selectedColor == color
//                       ? Colors.white
//                       : Colors.transparent,
//                   width: 2,
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

// //Choix de couleurs et equuip
// class PlayerSelectionScreen extends StatefulWidget {
//   const PlayerSelectionScreen({super.key});

//   @override
//   _PlayerSelectionScreenState createState() => _PlayerSelectionScreenState();
// }

// class _PlayerSelectionScreenState extends State<PlayerSelectionScreen> {
//   late TextEditingController player1Controller;
//   late TextEditingController player2Controller;
//   Color player1Color = const Color(0xFF137C8B);
//   Color player2Color = const Color(0xFF709CA7);

//   @override
//   void initState() {
//     super.initState();
//     player1Controller = TextEditingController();
//     player2Controller = TextEditingController();
//   }

//   @override
//   void dispose() {
//     player1Controller.dispose();
//     player2Controller.dispose();
//     super.dispose();
//   }

//   void startGame() {
//     if (player1Controller.text.isNotEmpty &&
//         player2Controller.text.isNotEmpty) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => TicTacToeGameScreen(
//             player1Name: player1Controller.text,
//             player2Name: player2Controller.text,
//             player1Color: player1Color,
//             player2Color: player2Color,
//           ),
//         ),
//       );
//     } else {
//       // Show a dialog to inform the user to enter player names
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Please enter player names'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Player Selection'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: player1Controller,
//               decoration: const InputDecoration(
//                 labelText: 'Player 1 Name',
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Player 1 color selection
//             ColorSelectionWidget(
//               selectedColor: player1Color,
//               onColorSelected: (color) {
//                 setState(() {
//                   player1Color = color;
//                 });
//               },
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: player2Controller,
//               decoration: const InputDecoration(
//                 labelText: 'Player 2 Name',
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Player 2 color selection
//             ColorSelectionWidget(
//               selectedColor: player2Color,
//               onColorSelected: (color) {
//                 setState(() {
//                   player2Color = color;
//                 });
//               },
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: startGame,
//               child: const Text('Start Game'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TicTacToeGameScreen extends StatefulWidget {
//   final String player1Name;
//   final String player2Name;
//   final Color player1Color;
//   final Color player2Color;

//   const TicTacToeGameScreen({
//     super.key,
//     required this.player1Name,
//     required this.player2Name,
//     required this.player1Color,
//     required this.player2Color,
//   });

//   @override
//   _TicTacToeGameScreenState createState() => _TicTacToeGameScreenState();
// }

// class _TicTacToeGameScreenState extends State<TicTacToeGameScreen> {
//   late List<List<String>> board;
//   late String currentPlayer;
//   late Color currentColor;
//   late bool gameOver;

//   @override
//   void initState() {
//     super.initState();
//     initializeBoard();
//   }

//   void initializeBoard() {
//     board = List.generate(3, (_) => List.filled(3, ''));
//     currentPlayer = 'X';
//     gameOver = false;
//   }

 
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Current Player: $currentPlayer',
//                 style:
//                     const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           GridView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: 9,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//             ),
//             itemBuilder: (BuildContext context, int index) {
//               int row = index ~/ 3;
//               int col = index % 3;

//               return GestureDetector(
//                 onTap: () => playMove(row, col),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                   ),
//                   child: Center(
//                     child: Text(
//                       board[row][col],
//                       style: const TextStyle(fontSize: 40.0),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
