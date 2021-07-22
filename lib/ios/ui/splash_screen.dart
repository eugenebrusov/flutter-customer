
import 'package:customer/util/async.dart';
import 'package:customer/bloc/splash_bloc.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = 'splash';

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    child: Container(
      color: Themes.CupertinoTheme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamListenableBuilder<String>(
              stream: Provider.of<SplashBloc>(context).routeStream,
              listener: (route) => Navigator.pushNamedAndRemoveUntil(context, route, (Route<dynamic> route) => false)
          ),
          Image(image: AssetImage('assets/icons/logo_white.png')),
        ],
      ),
    ),
  );
}
