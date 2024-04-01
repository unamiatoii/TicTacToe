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

  // Convertir une instance de GameHistory en JSON
  Map<String, dynamic> toJson() {
    return {
      'player1': player1,
      'player2': player2,
      'result': result,
      'date': date.toIso8601String(),
    };
  }
}

