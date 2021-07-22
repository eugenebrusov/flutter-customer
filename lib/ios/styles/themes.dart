import 'package:customer/style/dimensions_theme_data.dart';
import 'package:flutter/cupertino.dart' as System;
import 'package:flutter/cupertino.dart';

const DimensionsThemeData _kDefaultDimensions = DimensionsThemeData(
  windowEdgeLeftInset: 24.0,
  windowEdgeRightInset: 24.0,
);

class CupertinoTheme extends System.CupertinoTheme {
  static CupertinoThemeData of(System.BuildContext context) =>
      System.CupertinoTheme.of(context) as CupertinoThemeData;
}

class CupertinoThemeData extends System.CupertinoThemeData {
  const CupertinoThemeData({
    Brightness brightness,
    Color primaryColor = _CupertinoColors.primary,
    Color primaryContrastingColor,
    CupertinoTextThemeData textTheme = _CupertinoTypography.iOS13,
    Color barBackgroundColor = _CupertinoColors.barBackground,
    Color scaffoldBackgroundColor,
    this.dimensionsTheme = _kDefaultDimensions,
    this.inactiveTabBarColor = _CupertinoColors.onScaffoldBackground60,
    this.navBarElementsColor = _CupertinoColors.onScaffoldBackground100,
    this.navBarBorderColor = _CupertinoColors.borderColor
  }) : super(
            brightness: brightness,
            primaryColor: primaryColor,
            primaryContrastingColor: primaryContrastingColor,
            textTheme: textTheme,
            barBackgroundColor: barBackgroundColor,
            scaffoldBackgroundColor: scaffoldBackgroundColor);

  final DimensionsThemeData dimensionsTheme;
  final Color inactiveTabBarColor;
  final Color navBarElementsColor;
  final Color navBarBorderColor;

  @override
  CupertinoTextThemeData get textTheme =>
      super.textTheme as CupertinoTextThemeData;

  @override
  CupertinoThemeData resolveFrom(BuildContext context, {bool nullOk = false}) {
    return this;
  }
}

class CupertinoTextThemeData extends System.CupertinoTextThemeData {
  const CupertinoTextThemeData({
    Color primaryColor = _CupertinoColors.primary,
    TextStyle textStyle,
    TextStyle actionTextStyle,
    TextStyle tabLabelTextStyle,
    TextStyle navTitleTextStyle,
    TextStyle navLargeTitleTextStyle,
    TextStyle navActionTextStyle,
    TextStyle pickerTextStyle,
    TextStyle dateTimePickerTextStyle,
    @required this.largeTitleTextStyleSet,
    @required this.title1TextStyleSet,
    @required this.title2TextStyleSet,
    @required this.headlineTextStyleSet,
    @required this.bodyTextStyleSet,
    @required this.calloutTextStyleSet,
    @required this.subheadlineTextStyleSet,
    @required this.footnoteTextStyleSet,
    @required this.caption1TextStyleSet,
    @required this.caption2TextStyleSet
  }) : super(
      primaryColor: primaryColor,
      textStyle: textStyle,
      actionTextStyle: actionTextStyle,
      tabLabelTextStyle: tabLabelTextStyle,
      navTitleTextStyle: navTitleTextStyle,
      navLargeTitleTextStyle: navLargeTitleTextStyle,
      navActionTextStyle: navActionTextStyle,
      pickerTextStyle: pickerTextStyle,
      dateTimePickerTextStyle: dateTimePickerTextStyle);

  final CupertinoTextStyleSet largeTitleTextStyleSet;
  final CupertinoTextStyleSet title1TextStyleSet;
  final CupertinoTextStyleSet title2TextStyleSet;
  final CupertinoTextStyleSet headlineTextStyleSet;
  final CupertinoTextStyleSet bodyTextStyleSet;
  final CupertinoTextStyleSet calloutTextStyleSet;
  final CupertinoTextStyleSet subheadlineTextStyleSet;
  final CupertinoTextStyleSet footnoteTextStyleSet;
  final CupertinoTextStyleSet caption1TextStyleSet;
  final CupertinoTextStyleSet caption2TextStyleSet;
}

/// Defines text geometry
///
/// The font sizes, weights, and letter spacings in this version match the
/// [latest Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/).
///
/// The colors in this version watch the
/// [latest Dynamic System Colors](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/).
class _CupertinoTypography {
  _CupertinoTypography._();

  static const TextStyle _largeTitleLabel = TextStyle(
      inherit: false,
      fontFamily: 'Nunito',
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.37,
      color: _CupertinoColors.onScaffoldBackground100);

  static const TextStyle _title1Label = TextStyle(
      inherit: false,
      fontFamily: 'Nunito',
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      color: _CupertinoColors.onScaffoldBackground100);

  static const TextStyle _title2Label = TextStyle(
      inherit: false,
      fontFamily: 'Nunito',
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.27,
      color: _CupertinoColors.onScaffoldBackground100);

  static const TextStyle _headlineLabel = TextStyle(
      inherit: false,
      fontFamily: 'Nunito',
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.41,
      color: _CupertinoColors.onScaffoldBackground100);

  static const TextStyle _bodyLabel = TextStyle(
      inherit: false,
      fontFamily: 'Nunito',
      fontSize: 17.0,
      fontWeight: FontWeight.normal,
      letterSpacing: -0.41,
      color: _CupertinoColors.onScaffoldBackground100);

  static const TextStyle _bodyLink = TextStyle(
      inherit: false,
      fontFamily: 'Nunito',
      fontSize: 17.0,
      fontWeight: FontWeight.normal,
      letterSpacing: -0.41,
      color: _CupertinoColors.primary);

  static const TextStyle _calloutLabel = TextStyle(
      inherit: false,
      fontFamily: 'Nunito',
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.32,
      color: _CupertinoColors.onScaffoldBackground100);

  static const TextStyle _subheadlineLabel = TextStyle(
      inherit: false,
      fontFamily: 'Nunito',
      fontSize: 15.0,
      fontWeight: FontWeight.normal,
      letterSpacing: -0.24,
      color: _CupertinoColors.onScaffoldBackground100);

  static const TextStyle _subheadlineSecondaryLabel = TextStyle(
      inherit: false,
      fontFamily: 'Nunito',
      fontSize: 15.0,
      fontWeight: FontWeight.normal,
      letterSpacing: -0.24,
      color: _CupertinoColors.onScaffoldBackground60);

  static const TextStyle _subheadlineLinkLabel = TextStyle(
      inherit: false,
      fontFamily: 'Nunito',
      fontSize: 15.0,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.24,
      color: _CupertinoColors.primary);

  static const TextStyle _footnoteSecondaryLabel = TextStyle(
      inherit: false,
      fontFamily: 'Nunito',
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      letterSpacing: -0.08,
      color: _CupertinoColors.onScaffoldBackground60);

  static const TextStyle _caption1Label = TextStyle(
      inherit: false,
      fontFamily: 'Dosis',
      fontSize: 13.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 0,
      color: _CupertinoColors.onScaffoldBackground100);

  static const TextStyle _caption1Link = TextStyle(
      inherit: false,
      fontFamily: 'Dosis',
      fontSize: 13.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 0,
      color: _CupertinoColors.primary);

  static const TextStyle _caption2Label = TextStyle(
      inherit: false,
      fontFamily: 'Dosis',
      fontSize: 11.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.07,
      color: _CupertinoColors.onScaffoldBackground100);

  static const TextStyle _caption2SecondaryLabel = TextStyle(
      inherit: false,
      fontFamily: 'Dosis',
      fontSize: 11.0,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
      color: _CupertinoColors.onScaffoldBackground60);

  static const TextStyle _caption2Link = TextStyle(
      inherit: false,
      fontFamily: 'Dosis',
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.07,
      color: _CupertinoColors.primary);

  static const CupertinoTextThemeData iOS13 = CupertinoTextThemeData(
      tabLabelTextStyle: _caption2Label,
      navTitleTextStyle: _headlineLabel,
      navLargeTitleTextStyle: _largeTitleLabel,
      largeTitleTextStyleSet: CupertinoTextStyleSet(label: _largeTitleLabel),
      title1TextStyleSet: CupertinoTextStyleSet(label: _title1Label),
      title2TextStyleSet: CupertinoTextStyleSet(label: _title2Label),
      headlineTextStyleSet: CupertinoTextStyleSet(label: _headlineLabel),
      bodyTextStyleSet: CupertinoTextStyleSet(label: _bodyLabel, link: _bodyLink),
      calloutTextStyleSet: CupertinoTextStyleSet(label: _calloutLabel),
      subheadlineTextStyleSet: CupertinoTextStyleSet(label: _subheadlineLabel, secondaryLabel: _subheadlineSecondaryLabel, link: _subheadlineLinkLabel),
      footnoteTextStyleSet: CupertinoTextStyleSet(secondaryLabel: _footnoteSecondaryLabel),
      caption1TextStyleSet: CupertinoTextStyleSet(label: _caption1Label, link: _caption1Link),
      caption2TextStyleSet: CupertinoTextStyleSet(label: _caption2Label, secondaryLabel: _caption2SecondaryLabel, link: _caption2Link)
  );
}

class _CupertinoColors {
  _CupertinoColors._();

  static const Color primary = Color(0xFF5DA1A2);
  static const Color barBackground = Color(0xFFFFFFFF);

  static const Color onScaffoldBackground100 = Color(0xFF4F506C);
  static const Color onScaffoldBackground60 = Color(0x994F506C);

  static const Color borderColor = Color(0x29000000);
}

class CupertinoTextStyleSet {
  const CupertinoTextStyleSet({
    this.label = const System.TextStyle(),
    this.secondaryLabel = const System.TextStyle(),
    this.tertiaryLabel = const System.TextStyle(),
    this.link = const System.TextStyle(),
  });

  final TextStyle label;
  final TextStyle secondaryLabel;
  final TextStyle tertiaryLabel;
  final TextStyle link;
}
