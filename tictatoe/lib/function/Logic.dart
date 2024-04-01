import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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
  late List<List<String>> board;
  List<GameHistory> gameHistory = [];
  bool player1Turn = true;

  GameLogic({required int gridSize}) {
    board = List.generate(
      gridSize,
      (_) => List.filled(gridSize, ''),
    );
    initializeBoard();
  }

  bool playMove(int row, int col) {
    if (board[row][col].isEmpty) {
      board[row][col] = player1Turn ? 'X' : 'O';
      player1Turn = !player1Turn;
      return true;
    }
    return false;
  }

  bool checkForWinner(int row, int col) {
    String player = board[row][col];
    int target = 3; // Nombre d'éléments à aligner pour gagner (dans ce cas, 3)

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

    for (int i = 0; i < board.length; i++) {
      if (checkLineOrColumn(row, i, 0, 1)) return true;
    }

    for (int i = 0; i < board.length; i++) {
      if (checkLineOrColumn(i, col, 1, 0)) return true;
    }

    if (checkLineOrColumn(row - col, 0, 1, 1)) return true;
    if (checkLineOrColumn(0, col - row, 1, 1)) return true;

    return false;
  }

  bool checkForDraw() {
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board.length; j++) {
        if (board[i][j].isEmpty) {
          return false;
        }
      }
    }
    return true;
  }

  void endGame(String winner, String player1Name, String player2Name) async {
    GameHistory game = GameHistory(
      player1: player1Name,
      player2: player2Name,
      result: winner,
      date: DateTime.now(),
    );

    List<GameHistory> history = await loadHistoryData();

    history.add(game);

    await writeHistoryToFile(history);

    initializeBoard();
  }

  void initializeBoard() {
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board.length; j++) {
        board[i][j] = ''; // Remplir chaque case avec une chaîne vide
      }
    }
    player1Turn = true; // Réinitialiser le tour au joueur 1
  }

  Future<List<GameHistory>> loadHistoryData() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/history.json';

    try {
      String jsonString = await File(filePath).readAsString();
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

  Future<void> writeHistoryToFile(List<GameHistory> history) async {
    List<Map<String, dynamic>> jsonDataList =
        history.map((game) => game.toJson()).toList();
    String jsonData = jsonEncode(jsonDataList);

    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/history.json';
      await File(filePath).writeAsString(jsonData);
      print('Données d\'historique des parties enregistrées dans $filePath');
    } catch (e) {
      print(
          'Erreur lors de l\'enregistrement des données d\'historique des parties : $e');
    }
  }
}
