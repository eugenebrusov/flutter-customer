
import 'package:flutter/foundation.dart';

class FavoriteUiModel {
  const FavoriteUiModel({
    @required this.assetName,
    @required this.action
  });

  final String assetName;
  final Function action;
}