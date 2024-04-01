import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictatoe/Model/PageModel.dart';
import 'package:tictatoe/Pages/GameMode.dart';
import 'package:tictatoe/Pages/Historydart';
import 'package:tictatoe/Pages/Setting.dart';

class CustomBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40.0),
        topRight: Radius.circular(40.0),
      ),
      child: BottomAppBar(
        elevation: 10,
        notchMargin: 8.0,
        color: Theme.of(context).colorScheme.onSurface,
        child: Consumer<PageIndexNotifier>(
          builder: (context, pageIndexNotifier, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.gamepad_outlined,
                    color: pageIndexNotifier.selectedIndex == 0
                        ? Colors.white
                        : Colors.grey,
                  ),
                  onPressed: () {
                    pageIndexNotifier.setPageIndex(0);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GameModeSelectionPage()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.history,
                    color: pageIndexNotifier.selectedIndex == 1
                        ? Colors.white
                        : Colors.grey,
                  ),
                  onPressed: () {
                    pageIndexNotifier.setPageIndex(1);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GameHistoryPage()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: pageIndexNotifier.selectedIndex == 2
                        ? Colors.white
                        : Colors.grey,
                  ),
                  onPressed: () {
                    pageIndexNotifier.setPageIndex(2);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
