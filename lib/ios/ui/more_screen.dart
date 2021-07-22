import 'package:customer/ios/styles/themes.dart' as Themes;
import 'package:customer/localizations/app_localizations.dart';
import 'package:flutter/cupertino.dart';

class MoreScreen extends StatelessWidget {

  Widget _buildUserUnauthorizedListItem(BuildContext context) =>
      Container(
        height: 60.0,
        child: Row(
          children: <Widget>[
            ClipOval(
              child: Container(
                width: 56.0,
                height: 56.0,
                child: Center(
                  child: Text('?'),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(AppLocalizations.of(context).signInToAccountTitle,
                      style: Themes.CupertinoTheme.of(context).textTheme.bodyTextStyleSet.link,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    Text('To order products, contact suppliers and more',
                      style: Themes.CupertinoTheme.of(context).textTheme.subheadlineTextStyleSet.secondaryLabel,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ]
                ),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) =>
      CupertinoPageScaffold(
          child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.only(left: 16.0, top: 32.0),
                children: <Widget>[
                  _buildUserUnauthorizedListItem(context)
                ],
              )
          )
      );
}