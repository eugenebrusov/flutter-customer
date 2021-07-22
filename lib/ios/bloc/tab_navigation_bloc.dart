
import 'package:flutter/cupertino.dart';

class NavigationBloc {
  NavigationBloc();

  final CupertinoTabController controller = CupertinoTabController();

  void dispose() {
    controller.dispose();
  }

  void switchTab(int index) {
    controller.index = index;
  }
}