
import 'package:customer/android/login_screen.dart';
import 'package:customer/util/async.dart';
import 'package:customer/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<SplashBloc>(
        create: (context) => SplashBloc(),
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StreamListenableBuilder<void>(
                      stream: Provider.of<SplashBloc>(context).routeStream,
                      listener: (value) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (c, a1, a2) => LoginScreen(),
                              transitionsBuilder: (c, anim, a2, child) =>
                                  FadeTransition(opacity: anim, child: child),
                              transitionDuration: Duration(milliseconds: 500),
                            ),
                            (Route<dynamic> route) => false);
                      }),
                  Image(image: AssetImage('graphics/splash.png')),
                ],
              ),
            ),
          );
        })
    );
  }
}
