import 'package:flutter/foundation.dart';

class PageIndexNotifier extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setPageIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
