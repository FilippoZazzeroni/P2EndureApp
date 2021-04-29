import 'package:flutter/services.dart';
import 'package:p2Endure/ui/views/baseModel.dart';

class MainViewModel extends BaseModel {
  int _index = 0;

  ///get index della navigation bar
  int get index => _index;

  DateTime _currentBackPressTime = DateTime.now();

  void onItemTap(int index) {
    _index = index;
    notifyListeners();
  }

  Future backButtonCallBack() {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime) > Duration(seconds: 2)) {
      _currentBackPressTime = now;
      showToast("press two times to exit the app");
      return Future.value(false);
    }

    SystemNavigator.pop();
    return Future.value(true);
  }
}
