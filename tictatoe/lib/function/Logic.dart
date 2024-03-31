// Classe contenant la logique du jeu
class GameLogic {
  late List<List<String>> board; // Plateau de jeu dynamique

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
    bool won = true;

    // Vérifie la ligne
    for (int i = 0; i < board.length; i++) {
      if (board[row][i] != player) {
        won = false;
        break;
      }
    }
    if (won) return true;

    // Vérifie la colonne
    won = true;
    for (int i = 0; i < board.length; i++) {
      if (board[i][col] != player) {
        won = false;
        break;
      }
    }
    if (won) return true;

    // Vérifie les diagonales
    if (row == col) {
      won = true;
      for (int i = 0; i < board.length; i++) {
        if (board[i][i] != player) {
          won = false;
          break;
        }
      }
      if (won) return true;
    }

    if (row + col == board.length - 1) {
      won = true;
      for (int i = 0; i < board.length; i++) {
        if (board[i][board.length - 1 - i] != player) {
          won = false;
          break;
        }
      }
      if (won) return true;
    }

    return false; // Retourne false s'il n'y a pas de gagnant
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

  // Fonction pour réinitialiser le plateau de jeu
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
}
