import 'package:flutter/material.dart';

class GameLogic {
  List<List<String>> board = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];
  bool player1Turn = true;

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

  bool checkForDraw() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          return false;
        }
      }
    }
    return true;
  }

  void initializeBoard() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        board[i][j] = '';
      }
    }
    player1Turn = true;
  }
}
