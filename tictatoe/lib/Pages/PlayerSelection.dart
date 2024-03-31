import 'package:flutter/material.dart';
import 'package:tictatoe/Pages/Bord.dart';
import 'package:tictatoe/component/AppBar.dart';
import 'package:tictatoe/component/BottomAppBar.dart';
import 'package:tictatoe/component/ChoosePlayer.dart';

class ColorSelectionPage extends StatefulWidget {
  final int difficultyLevel;

  const ColorSelectionPage({Key? key, required this.difficultyLevel})
      : super(key: key);
  @override
  _ColorSelectionPageState createState() => _ColorSelectionPageState();
}

class _ColorSelectionPageState extends State<ColorSelectionPage> {
  Color _player1Color = Colors.red; // Couleur par défaut pour le joueur 1
  Color _player2Color = Colors.blue; // Couleur par défaut pour le joueur 2
  final TextEditingController _player1Controller = TextEditingController();
  final TextEditingController _player2Controller = TextEditingController();

  final List<Color> _availableColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.indigo,
    Colors.pink,
    Colors.amber,
  ];

  final double _verticalSpacing = 20.0;
  final double _buttonHeight = 40.0;
  final double _buttonWidth = 120.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(),
      appBar: const RoundedAppBar(
        title: "TIC",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: _verticalSpacing),
            NameAndColorPickerInput(
              nameController: _player1Controller,
              nameLabelText: "Joueur 1",
              selectedColor: _player1Color,
              availableColors: _availableColors,
              onColorChanged: (color) {
                setState(() {
                  _player1Color = color;
                });
              },
            ),
            SizedBox(height: _verticalSpacing),
            NameAndColorPickerInput(
              nameController: _player2Controller,
              nameLabelText: "Joueur 2",
              selectedColor: _player2Color,
              availableColors: _availableColors,
              onColorChanged: (color) {
                setState(() {
                  _player2Color = color;
                });
              },
            ),
            SizedBox(height: _verticalSpacing * 2),
            ElevatedButton(
              onPressed: () {
                final playerName = _player1Controller.text;
                if (playerName.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicTacToeBoard(
                        player1Name: playerName,
                        player2Name: _player2Controller.text,
                        player1Color: _player1Color,
                        player2Color: _player2Color,
                        difficultyLevel: widget.difficultyLevel,
                      ),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Attention"),
                        content: Text("Veuillez saisir le nom du Joueur 1."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Commencer',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}