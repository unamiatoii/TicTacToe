import 'package:flutter/material.dart';
import 'package:tictatoe/Pages/GameMode.dart';
import 'package:tictatoe/Pages/Historydart';
import 'package:tictatoe/function/ChangePage.dart';

class CustomBottomAppBar extends StatefulWidget {
  final List<VoidCallback?>? onPressed;

  const CustomBottomAppBar({super.key, this.onPressed});

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int _selectedIndex = 0;

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.gamepad_outlined,
                color: _selectedIndex == 0 ? Colors.white : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                  navigateToPage(context, const GameModeSelectionPage());
                });
                if (widget.onPressed != null) widget.onPressed![0]?.call();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.history,
                color: _selectedIndex == 1 ? Colors.white : Colors.grey,
              ),
              onPressed: () {
                navigateToPage(context, GameHistoryPage());

                setState(() {
                  _selectedIndex = 1;
                });
                if (widget.onPressed != null) widget.onPressed![1]?.call();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: _selectedIndex == 2 ? Colors.white : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
                if (widget.onPressed != null) widget.onPressed![2]?.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}
