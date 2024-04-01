import 'package:flutter/material.dart';

// Fonction pour créer une transition personnalisée
PageRouteBuilder _customPageRouteBuilder(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Début de l'animation (hors écran à droite)
      const end = Offset.zero; // Fin de l'animation (à l'emplacement actuel)
      const curve = Curves.ease; // Courbe d'animation (lissage)
      
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

// Utilisation de la transition personnalisée lors de la navigation
void navigateToPage(BuildContext context, Widget page) {
  Navigator.of(context).push(_customPageRouteBuilder(page));
}

