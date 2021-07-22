
import 'package:customer/ios/ui/browse/browse_screen.dart';
import 'package:flutter/cupertino.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Login Screen v2'),
            CupertinoButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (c, a1, a2) => BrowseScreen(),
                      transitionsBuilder: (c, anim, a2, child) =>
                          FadeTransition(opacity: anim, child: child),
                      transitionDuration: Duration(milliseconds: 250),
                    ), (Route<dynamic> route) => false);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}