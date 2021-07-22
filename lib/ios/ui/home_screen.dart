import 'package:customer/ios/bloc/tab_navigation_bloc.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;
import 'package:customer/ios/ui/browse/browse_screen.dart';
import 'package:customer/ios/ui/favorites/favorites_screen.dart';
import 'package:customer/ios/ui/inbox_screen.dart';
import 'package:customer/ios/ui/more_screen.dart';
import 'package:customer/ios/ui/orders_screen.dart';
import 'package:customer/localizations/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home';

  HomeScreen({
    Key key,
    @required RouteFactory tabRouteFactory
  }) : _tabRouteFactory = tabRouteFactory,
        super(key: key);

  final RouteFactory _tabRouteFactory;

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
    controller: Provider.of<NavigationBloc>(context, listen: false).controller,
    tabBar: CupertinoTabBar(
      backgroundColor: Themes.CupertinoTheme.of(context).scaffoldBackgroundColor,
      inactiveColor: Themes.CupertinoTheme.of(context).inactiveTabBarColor,
      items: <BottomNavigationBarItem>[
        _buildBottomNavigationBarItemInbox(context),
        _buildBottomNavigationBarItemOrders(context),
        _buildBottomNavigationBarItemBrowse(context),
        _buildBottomNavigationBarItemFavorites(context),
        _buildBottomNavigationBarItemMore(context)
      ],
    ),
    tabBuilder: (context, index) {
      switch (index) {
        case 0:
          return CupertinoTabView(
              onGenerateRoute: _tabRouteFactory,
              builder: (context) => InboxScreen()
          );
        case 1:
          return CupertinoTabView(
              onGenerateRoute: _tabRouteFactory,
              builder: (context) => OrdersScreen()
          );
        case 2:
          return CupertinoTabView(
              onGenerateRoute: _tabRouteFactory,
              builder: (context) => BrowseScreen()
          );
        case 3:
          return CupertinoTabView(
              onGenerateRoute: _tabRouteFactory,
              builder: (context) => FavoritesScreen()
          );
        case 4:
          return CupertinoTabView(
              onGenerateRoute: _tabRouteFactory,
              builder: (context) => MoreScreen()
          );
        default:
          assert(false, 'Unexpected tab index $index');
          return null;
      }
    },
  );

  BottomNavigationBarItem _buildBottomNavigationBarItemInbox(BuildContext context) =>
      BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icons/tab_inbox_inactive.png')),
          activeIcon: ImageIcon(AssetImage('assets/icons/tab_inbox_active.png')),
          title: Text(AppLocalizations.of(context).tabTitleInbox.toUpperCase())
      );

  BottomNavigationBarItem _buildBottomNavigationBarItemOrders(BuildContext context) =>
      BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icons/tab_orders_inactive.png')),
          activeIcon: ImageIcon(AssetImage('assets/icons/tab_orders_active.png')),
          title: Text(AppLocalizations.of(context).tabTitleOrders.toUpperCase())
      );

  BottomNavigationBarItem _buildBottomNavigationBarItemBrowse(BuildContext context) =>
      BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icons/tab_browse_inactive.png')),
          activeIcon: ImageIcon(AssetImage('assets/icons/tab_browse_active.png')),
          title: Text(AppLocalizations.of(context).tabTitleBrowse.toUpperCase())
      );

  BottomNavigationBarItem _buildBottomNavigationBarItemFavorites(BuildContext context) =>
      BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icons/tab_favorites_inactive.png')),
          activeIcon: ImageIcon(AssetImage('assets/icons/tab_favorites_active.png')),
          title: Text(AppLocalizations.of(context).tabTitleFavorites.toUpperCase())
      );

  BottomNavigationBarItem _buildBottomNavigationBarItemMore(BuildContext context) =>
      BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icons/tab_more_inactive.png')),
          activeIcon: ImageIcon(AssetImage('assets/icons/tab_more_active.png')),
          title: Text(AppLocalizations.of(context).tabTitleMore.toUpperCase())
      );
}