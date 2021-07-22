
import 'package:flutter/cupertino.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
          child: ImageIcon(AssetImage('assets/icons/back_arrow.png'), color: Themes.CupertinoTheme.of(context).inactiveTabBarColor),
        )
    );
  }
}