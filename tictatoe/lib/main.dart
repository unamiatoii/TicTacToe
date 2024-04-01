import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictatoe/Model/PageModel.dart';
import 'package:tictatoe/Pages/GameMode.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const TicTacToe());
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PageIndexNotifier(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          hintColor: const Color.fromRGBO(17, 20, 26, 1),
          colorScheme: const ColorScheme(
            background: Color.fromRGBO(185, 204, 234, 1),
            surface: Color.fromRGBO(17, 20, 26, 1),
            onBackground: Color(0xFF7A90A4),
            onSurface: Color(0xFF344D59),
            brightness: Brightness.light,
            primary: Color.fromRGBO(185, 204, 234, 1),
            onPrimary: Colors.white,
            secondary: Color.fromRGBO(17, 20, 26, 1),
            onSecondary: Colors.white,
            error: Color(0xFFEF5350),
            onError: Colors.white,
            tertiary: Color.fromRGBO(7, 9, 10, 1),
          ),
          textTheme: GoogleFonts.outfitTextTheme(),
        ),
        home: const GameModeSelectionPage(),
      ),
    );
  }
}
