import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tictatoe/component/AppBar.dart';
import 'package:tictatoe/component/BottomAppBar.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RoundedAppBar(
        title: 'Paramètres',
      ),
      bottomNavigationBar: CustomBottomAppBar(),
      body: Center(
        child: Container(
          height: 200,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDeleteDataButton(context),
              _buildAboutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteDataButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDeleteDataConfirmationDialog(context);
      },
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.delete,
              size: 25,
              color: Theme.of(context).colorScheme.error,
            ),
            Expanded(
              child: Text(
                'Supprimer les données',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showAboutDialog(context);
      },
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.info_outline,
              size: 25,
              color: Theme.of(context).colorScheme.primary,
            ),
            Expanded(
              child: Text(
                'À propos de l\'application',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteDataConfirmationDialog(BuildContext context) async {
    bool _isLoading = false; // Variable pour suivre l'état de chargement

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Supprimer les données'),
              content: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Text(
                      'Êtes-vous sûr de vouloir supprimer toutes les données ?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Annuler'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    'Supprimer',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                  onPressed: _isLoading
                      ? null // Désactiver le bouton pendant le chargement
                      : () async {
                          setState(() {
                            _isLoading =
                                true; // Activer l'animation de chargement
                          });
                          await _deleteData();
                          Navigator.of(context).pop();
                        },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showAboutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('À propos de l\'application'),
          content: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nom de l\'application : Tic Tac Toe'),
              Text('Version : 1.0.0'),
              Text('Développeur : unamiatoii'),
              Text('GitHub : unamiatoii'),
              // Ajoutez d'autres informations comme votre email, site web, etc.
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Fermer',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.surface),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteData() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/history.json';
    File file = File(filePath);
    await file.writeAsString(
        jsonEncode([])); // Videz le fichier en écrivant un tableau JSON vide.
  }
}
