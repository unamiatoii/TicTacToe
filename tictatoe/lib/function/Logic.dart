import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// Classe de données pour représenter une partie
class GameHistory {
  final String player1;
  final String player2;
  final String result;
  final DateTime date;

  GameHistory({
    required this.player1,
    required this.player2,
    required this.result,
    required this.date,
  });

  // Fonction pour convertir une instance de GameHistory en JSON
  Map<String, dynamic> toJson() {
    return {
      'player1': player1,
      'player2': player2,
      'result': result,
      'date': date.toIso8601String(),
    };
  }
}

class GameLogic {
  late List<List<String>> board; // Plateau de jeu dynamique
  List<GameHistory> gameHistory =
      []; // Liste pour stocker l'historique des parties

  // Booléen indiquant si c'est le tour du joueur 1
  bool player1Turn = true;

  // Constructeur prenant en compte la taille du plateau de jeu
  GameLogic({required int gridSize}) {
    // Initialiser le plateau de jeu avec la taille spécifiée
    board = List.generate(
      gridSize,
      (_) => List.filled(gridSize, ''),
    );
  }

  // Fonction pour jouer un coup
  bool playMove(int row, int col) {
    // Vérifie si la case est vide
    if (board[row][col].isEmpty) {
      // Place le symbole du joueur actuel dans la case
      board[row][col] = player1Turn ? 'X' : 'O';
      // Change le tour du joueur
      player1Turn = !player1Turn;
      return true; // Retourne true si le coup a été joué avec succès
    }
    return false; // Retourne false si la case est déjà occupée
  }

// Fonction pour vérifier s'il y a un gagnant
  bool checkForWinner(int row, int col) {
    String player = board[row][col];
    int target = 3; // Nombre d'éléments à aligner pour gagner

    // Fonction pour vérifier si une ligne ou une colonne contient un alignement de 'target' éléments
    bool checkLineOrColumn(int i, int j, int di, int dj) {
      int count = 0;
      while (i >= 0 &&
          i < board.length &&
          j >= 0 &&
          j < board.length &&
          board[i][j] == player) {
        count++;
        i += di;
        j += dj;
      }
      return count == target;
    }

    // Vérifie la ligne
    for (int i = 0; i < board.length; i++) {
      if (checkLineOrColumn(row, i, 0, 1)) return true;
    }

    // Vérifie la colonne
    for (int i = 0; i < board.length; i++) {
      if (checkLineOrColumn(i, col, 1, 0)) return true;
    }

    // Vérifie les diagonales
    for (int i = -board.length + 1; i < board.length; i++) {
      if (checkLineOrColumn(i < 0 ? -i : 0, i < 0 ? 0 : i, 1, 1)) return true;
      if (checkLineOrColumn(
          i < 0 ? -i : 0, board.length - 1 - (i < 0 ? 0 : i), 1, -1))
        return true;
    }

    return false;
  }

  // Fonction pour vérifier s'il y a un match nul
  bool checkForDraw() {
    // Parcourt toutes les cases du plateau
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board.length; j++) {
        // S'il y a une case vide, le jeu n'est pas un match nul
        if (board[i][j].isEmpty) {
          return false;
        }
      }
    }
    return true; // S'il n'y a pas de case vide, c'est un match nul
  }

  // Fonction pour terminer une partie et enregistrer les données
  // Fonction pour terminer une partie et enregistrer les données
  void endGame(String winner, String player1Name, String player2Name) async {
    // Créer une nouvelle instance de GameHistory avec les données de la partie
    GameHistory game = GameHistory(
      player1: player1Name,
      player2: player2Name,
      result: winner,
      date: DateTime.now(),
    );

    // Charger les données actuelles depuis le fichier JSON
    List<GameHistory> history = await loadHistoryData();

    // Ajouter la partie à l'historique
    history.add(game);

    // Écrire les données dans le fichier JSON
    await writeHistoryToFile(history);

    // Réinitialiser le plateau de jeu pour la prochaine partie
    initializeBoard();
  }

  void initializeBoard() {
    // Parcourt toutes les cases du plateau
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board.length; j++) {
        // Remplit chaque case avec une chaîne vide
        board[i][j] = '';
      }
    }
    player1Turn = true; // Remet le tour au joueur 1
  }

  // Fonction pour charger les données depuis le fichier JSON
  Future<List<GameHistory>> loadHistoryData() async {
    // Obtenez le répertoire d'application
    Directory directory = await getApplicationDocumentsDirectory();
    // Obtenez le chemin complet du fichier JSON
    String filePath = '${directory.path}/history.json';

    try {
      // Lire le contenu du fichier JSON
      String jsonString = await File(filePath).readAsString();
      // Convertir la chaîne JSON en liste d'objets GameHistory
      List<dynamic> jsonData = json.decode(jsonString);
      List<GameHistory> historyData = jsonData
          .map((game) => GameHistory(
                player1: game['player1'],
                player2: game['player2'],
                result: game['result'],
                date: DateTime.parse(game['date']),
              ))
          .toList();
      return historyData;
    } catch (e) {
      print('Erreur lors du chargement des données : $e');
      return [];
    }
  }

  // Fonction pour écrire les données dans le fichier JSON
  Future<void> writeHistoryToFile(List<GameHistory> history) async {
    // Convertir la liste d'instances GameHistory en une liste de JSON
    List<Map<String, dynamic>> jsonDataList =
        history.map((game) => game.toJson()).toList();
    // Convertir la liste de JSON en une chaîne JSON
    String jsonData = jsonEncode(jsonDataList);

    try {
      // Obtenez le répertoire d'application
      Directory directory = await getApplicationDocumentsDirectory();
      // Obtenez le chemin complet du fichier JSON
      String filePath = '${directory.path}/history.json';
      // Écrire les données JSON dans le fichier
      await File(filePath).writeAsString(jsonData);
      print('Données d\'historique des parties enregistrées dans $filePath');
    } catch (e) {
      print(
          'Erreur lors de l\'enregistrement des données d\'historique des parties : $e');
    }
  }
}
