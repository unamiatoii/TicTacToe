import 'package:flutter/material.dart';

class RoundedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const RoundedAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context)
              .colorScheme
              .onSecondary, // Utilisation de la couleur de texte sur le fond secondaire
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back, // Ajout de l'icône de retour
          color: Theme.of(context)
              .colorScheme
              .onSecondary, // Utilisation de la couleur de texte sur le fond secondaire
        ),
        onPressed: () {
          Navigator.of(context).pop(); // Fonction de retour
        },
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20), // Arrondir les bords du bas
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
