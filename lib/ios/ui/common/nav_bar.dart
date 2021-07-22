
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;
import 'package:flutter/services.dart';

const double _kNavBarPersistentHeight = 44.0;
const double _kHeaderAspectRatio = 1.2;

class CupertinoSliverNavigationBar extends StatelessWidget {
  CupertinoSliverNavigationBar({
    Key key,
    @required String title,
    @required String imageUrl
  }) : _title = title,
      _imageUrl = imageUrl,
      super(key: key);

  final String _title;
  final String _imageUrl;

  @override
  Widget build(BuildContext context) => SliverPersistentHeader(
    pinned: true,
    delegate: _CupertinoSliverPersistentHeaderDelegate(
      context: context,
      title: _title,
      imageUrl: _imageUrl
    )
  );
}

class _CupertinoSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  _CupertinoSliverPersistentHeaderDelegate({
    BuildContext context,
    @required String title,
    @required String imageUrl
  }) : _context = context,
        _title = title,
        _imageUrl = imageUrl,
        super();

  final BuildContext _context;
  final String _title;
  final String _imageUrl;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: _isCollapsed(context, shrinkOffset) ? Brightness.light : Brightness.dark
    ));

    return Stack(
      children: <Widget>[
        OverflowBox(
          minHeight: 0.0,
          maxHeight: double.infinity,
          alignment: Alignment.bottomCenter,
          child: AspectRatio(
            aspectRatio: _kHeaderAspectRatio,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: _imageUrl
                ),
                Container(
                  color: Color(0x55000000),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          height: _kNavBarPersistentHeight,
          child: ImageIcon(
              AssetImage('assets/icons/back_arrow.png'),
              color: Themes.CupertinoTheme.of(context).barBackgroundColor
          ),
        ),
        AnimatedOpacity(
          duration: Duration(milliseconds: 150),
          opacity: _isCollapsed(context, shrinkOffset) ? 1.0 : 0.0,
          child: Stack(
            children: <Widget>[
              Container(
                height: _kNavBarPersistentHeight + MediaQuery.of(context).padding.top,
                decoration: BoxDecoration(
                    color: Themes.CupertinoTheme.of(context).scaffoldBackgroundColor,
                    border: Border(bottom: BorderSide(color: Themes.CupertinoTheme.of(context).navBarBorderColor))
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 14.0),
                child: CupertinoButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () => Navigator.of(context).pop(context),
                  child: ImageIcon(
                      AssetImage('assets/icons/back_arrow.png'),
                      color: Themes.CupertinoTheme.of(context).navBarElementsColor
                  ),
                ),
              ),
              Container(
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  alignment: Alignment.center,
                  child: Text(
                      _title,
                      style: Themes.CupertinoTheme.of(context).textTheme.title2TextStyleSet.label
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => MediaQuery.of(_context).size.width/_kHeaderAspectRatio;

  @override
  double get minExtent => _kNavBarPersistentHeight + MediaQuery.of(_context).padding.top;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;

  bool _isCollapsed(BuildContext context, double shrinkOffset) =>
      shrinkOffset > maxExtent - _kNavBarPersistentHeight - MediaQuery.of(context).padding.top;
}