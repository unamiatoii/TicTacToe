import 'package:flutter/material.dart';
import 'package:tictatoe/Pages/DifficultySelectionPage.dart'; // Importez la page de sélection de difficulté
import 'package:tictatoe/component/AppBar.dart';
import 'package:tictatoe/component/BottomAppBar.dart';
import 'package:tictatoe/component/ChoosePlayer.dart';
import 'package:tictatoe/function/ChangePage.dart';
import 'dart:math';

class PlayerSelectionPage extends StatefulWidget {
  final int mode;

  const PlayerSelectionPage({super.key, required this.mode});
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

  // Définir les données de l'ordinateur par défaut
  final String _computerName = 'Ordinateur';
  late Color _computerColor; // Couleur de l'ordinateur

  // Fonction pour choisir une couleur aléatoire parmi les couleurs disponibles
  Color _getRandomColor() {
    // Générer un indice aléatoire dans la plage des indices disponibles
    final randomIndex = Random().nextInt(_availableColors.length);
    // Récupérer la couleur correspondante à l'indice aléatoire
    return _availableColors[randomIndex];
  }

  @override
  void initState() {
    // Appeler initState de la classe parent
    super.initState();
    // Initialiser la couleur de l'ordinateur
    _computerColor = _getRandomColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  const CustomBottomAppBar(),
      appBar: const RoundedAppBar(
        title: "Choix des joueurs",
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
              // Afficher les options pour l'ordinateur uniquement si le mode est 2
              if (widget.mode == 2) ...[
                SizedBox(height: _verticalSpacing),
                NameAndColorPickerInput(
                  nameController: TextEditingController(text: _computerName),
                  nameLabelText: "Ordinateur",
                  selectedColor: _computerColor,
                  availableColors: _availableColors,
                  onColorChanged: (color) {
                    // Vous pouvez choisir de ne pas mettre à jour la couleur de l'ordinateur ici
                  },
                ),
              ],
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 5, 20, 40),
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.mode == 2) {
                      // Si le mode est 2, utiliser les données de l'ordinateur
                      navigateToPage(
                        context,
                        DifficultySelectionPage(
                          mode: widget.mode,
                          player1Name: _player1Controller.text,
                          player2Name: _computerName,
                          player1Color: _player1Color,
                          player2Color: _computerColor,
                        ),
                      );
                    } else {
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
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Attention"),
                              content: const Text(
                                  "Veuillez saisir le nom du Joueur 1."),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
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
