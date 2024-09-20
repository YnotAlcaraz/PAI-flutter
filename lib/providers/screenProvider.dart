import 'package:flutter/material.dart';
import 'package:pai_flutter/views/dashboard/dashboardScreen.dart';

class ScreenProvider extends ChangeNotifier {
  Widget _currentScreen = const DashboardScreen();

  Widget get currentScreen => _currentScreen;

  void updateScreen(Widget newScreen) {
    _currentScreen = newScreen;
    notifyListeners();
  }
}

class ExpandableMenuProvider extends ChangeNotifier {
  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;

  void updateExpanded(bool isExpanded) {
    _isExpanded = isExpanded;
    notifyListeners();
  }
}