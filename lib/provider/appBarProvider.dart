import 'package:flutter/foundation.dart';

class AppBarProvider extends ChangeNotifier {
  bool showNewAppBar = false;

  setFalse() {
    showNewAppBar = false;
    notifyListeners();
  }

  setTrue() {
    showNewAppBar = true;
    notifyListeners();
  }
}
