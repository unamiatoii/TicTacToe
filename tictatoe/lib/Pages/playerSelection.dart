import 'package:flutter/material.dart';
import 'package:tictatoe/Pages/Bord.dart';
import 'package:tictatoe/component/ChoosePlayer.dart';
import 'package:tictatoe/main.dart';

class ColorSelectionPage extends StatefulWidget {
  const ColorSelectionPage({Key? key}) : super(key: key);

  @override
  _ColorSelectionPageState createState() => _ColorSelectionPageState();
}

class _ColorSelectionPageState extends State<ColorSelectionPage> {
  Color _player1Color = Colors.red; // Couleur par défaut pour le joueur 1
  Color _player2Color = Colors.blue; // Couleur par défaut pour le joueur 2
  final TextEditingController _player1Controller = TextEditingController();
  final TextEditingController _player2Controller = TextEditingController();

  final Color primaryColor = Color(0xFF137C8B);
  final Color accentColor = Color(0xFF709CA7);
  final Color backgroundColor = Color(0xFFB8CBD0);
  final Color textColor = Color(0xFF7A90A4);
  final Color borderColor = Color(0xFF344D59);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: borderColor,
        title: const Text(
          'Choix des joueurs',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
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
              const SizedBox(height: 80),
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
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicTacToeBoard(
                        player1Name: _player1Controller.text,
                        player2Name: _player2Controller.text,
                        player1Color: _player1Color,
                        player2Color: _player2Color,
                      ),
                    ),
                  );
                },
                child: const Text('Next'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(
                  height:
                      20), // Ajout de l'espace entre le bouton et le bas de la colonne
            ],
          ),
        ),
      ),
    );
  }
}
