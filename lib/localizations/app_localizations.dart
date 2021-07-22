
import 'package:customer/localizations/l10n/messages_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  const AppLocalizations(this._localeName);

  final String _localeName;

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get tabTitleInbox {
    return Intl.message(
      'Inbox',
      name: 'tabTitleInbox',
      locale: _localeName,
    );
  }

  String get tabTitleOrders {
    return Intl.message(
      'Orders',
      name: 'tabTitleOrders',
      locale: _localeName,
    );
  }

  String get tabTitleBrowse {
    return Intl.message(
      'Browse',
      name: 'tabTitleBrowse',
      locale: _localeName,
    );
  }

  String get tabTitleFavorites {
    return Intl.message(
      'Favorites',
      name: 'tabTitleFavorites',
      locale: _localeName,
    );
  }

  String get tabTitleMore {
    return Intl.message(
      'More',
      name: 'tabTitleMore',
      locale: _localeName,
    );
  }

  String get signInToAccountTitle {
    return Intl.message(
      'Sign in to your Ebda account',
      name: 'signInToAccountTitle',
      locale: _localeName,
    );
  }

  String get signInToAccountSubtitle {
    return Intl.message(
      'To order products, contact suppliers and more',
      name: 'signInToAccountSubtitle',
      locale: _localeName,
    );
  }

  String buttonTitleSeeAll(int count) =>
      Intl.message(
        'See all ($count)',
        name: 'buttonTitleSeeAll',
        args: [count],
        locale: _localeName,
      );

  String get searchPlaceholderProducts {
    return Intl.message(
      'Search products',
      name: 'searchPlaceholderProducts',
      locale: _localeName,
    );
  }

  String get searchPlaceholderFavorites {
    return Intl.message(
      'Search favorites',
      name: 'searchPlaceholderFavorites',
      locale: _localeName,
    );
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<AppLocalizations> load(Locale locale) {
    final String localeName = Intl.canonicalizedLocale(locale.toString());
    return initializeMessages(localeName).then((_) {
      return AppLocalizations(localeName);
    });
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}