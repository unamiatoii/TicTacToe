import 'package:flutter/material.dart';
import 'package:tictatoe/Pages/DifficultySelectionPage.dart'; // Importez la page de sélection de difficulté
import 'package:tictatoe/component/AppBar.dart';
import 'package:tictatoe/component/BottomAppBar.dart';
import 'package:tictatoe/component/ChoosePlayer.dart';
import 'package:tictatoe/function/ChangePage.dart';

class PlayerSelectionPage extends StatefulWidget {
  final int mode;

  const PlayerSelectionPage({Key? key, required this.mode}) : super(key: key);
  @override
  _PlayerSelectionPageState createState() => _PlayerSelectionPageState();
}

class _PlayerSelectionPageState extends State<PlayerSelectionPage> {
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

  final double _verticalSpacing = 40.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(),
      appBar: const RoundedAppBar(
        title: "Choix des joueur",
      ),
      body: Center(
        // Enveloppez SingleChildScrollView avec Center
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              if (widget.mode == 1 || widget.mode == 3)
                SizedBox(height: _verticalSpacing),
              if (widget.mode == 1 || widget.mode == 3)
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
              SizedBox(height: 100),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 5, 20, 40),
                child: ElevatedButton(
                  onPressed: () {
                    final playerName = _player1Controller.text;
                    if (playerName.isNotEmpty) {
                      navigateToPage(
                        context,
                        DifficultySelectionPage(
                          mode: widget.mode,
                          player1Name: _player1Controller.text,
                          player2Name: _player2Controller.text,
                          player1Color: _player1Color,
                          player2Color: _player2Color,
                        ),
                      );
                      ;
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Attention"),
                            content:
                                Text("Veuillez saisir le nom du Joueur 1."),
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
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
