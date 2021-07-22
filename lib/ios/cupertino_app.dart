
import 'package:customer/bloc/browse/browse_bloc.dart';
import 'package:customer/bloc/favorites/favorites_bloc.dart';
import 'package:customer/bloc/inbox_bloc.dart';
import 'package:customer/bloc/product_details/product_details_bloc.dart';
import 'package:customer/bloc/splash_bloc.dart';
import 'package:customer/data/source/repository.dart';
import 'package:customer/ios/bloc/tab_navigation_bloc.dart';
import 'package:customer/ios/ui/home_screen.dart';
import 'package:customer/ios/ui/product_details/product_details_screen.dart';
import 'package:customer/ios/ui/splash_screen.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;
import 'package:customer/localizations/app_localizations.dart';
import 'package:flutter/cupertino.dart' as System;
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class CupertinoApp extends System.CupertinoApp {
  CupertinoApp() : super(
    debugShowCheckedModeBanner: false,
    title: 'Ebda iOS App',
    localizationsDelegates: [
      AppLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en', ''),
      const Locale('ar', ''),
    ],
    theme: Themes.CupertinoThemeData(),
    onGenerateRoute: _buildAppRouteFactory(),
  );
}

extension CupertinoAppExtension on CupertinoApp {
  RouteFactory _buildAppRouteFactory() => (route) {
    switch (route.name) {
      case Navigator.defaultRouteName:
      case SplashScreen.routeName:
        return _buildSplashRoute();
      case HomeScreen.routeName:
        return _buildHomeRoute();
      case ProductDetailsScreen.routeName:
        String productId = route.arguments as String;
        return _buildProductDetailsRoute(productId);
      default:
        assert(false, 'Unexpected route name ${route.name}');
        return null;
    }
  };

  Route _buildSplashRoute() => CupertinoPageRoute(
    builder: (context) => ProxyProvider<Repository, SplashBloc>(
      update: (context, repository, previous) => SplashBloc(repository: repository),
      dispose: (context, bloc) => bloc.dispose(),
      child: SplashScreen(),
    ),
  );

  Route _buildHomeRoute() => PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => MultiProvider(
      providers: [
        Provider<NavigationBloc>(
          create: (context) => NavigationBloc(),
          dispose: (context, bloc) => bloc.dispose(),
        ),
        ProxyProvider<Repository, InboxBloc>(
          update: (context, repository, previous) => InboxBloc(repository),
          dispose: (context, bloc) => bloc.dispose(),
        ),
        ProxyProvider<Repository, BrowseBloc>(
          update: (context, repository, previous) =>
              BrowseBloc(context: context, repository: repository),
          dispose: (context, bloc) => bloc.dispose(),
        ),
        ProxyProvider<Repository, FavoritesBloc>(
          update: (context, repository, previous) =>
              FavoritesBloc(context: context, repository: repository),
          dispose: (context, bloc) => bloc.dispose(),
        )
      ],
      child: Builder(builder: (context) => HomeScreen(tabRouteFactory: onGenerateRoute)),
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
    transitionDuration: Duration(milliseconds: 500),
  );

  Route _buildProductDetailsRoute(String productId) => CupertinoPageRoute(
    builder: (context) => ProxyProvider<Repository, ProductDetailsBloc>(
      update: (context, repository, previous) => ProductDetailsBloc(
          context: context,
          repository: repository,
          productId: productId
      ),
      dispose: (context, bloc) => bloc.dispose(),
      child: ProductDetailsScreen(),
    )
  );
}