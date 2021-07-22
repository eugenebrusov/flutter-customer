
import 'package:customer/data/source/repository.dart';
import 'package:customer/ios/ui/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class SplashBloc {
  SplashBloc({
    @required this.repository
  }) : routeStream = Stream.value(HomeScreen.routeName).delay(Duration(milliseconds: 1500));

  final Repository repository;
  final Stream<String> routeStream;

  void dispose() {
    print('SplashBloc dispose');
  }
}