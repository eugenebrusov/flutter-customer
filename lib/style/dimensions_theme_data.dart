
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class DimensionsThemeData extends Equatable {
  const DimensionsThemeData({
    @required this.windowEdgeLeftInset,
    @required this.windowEdgeRightInset,
  });

  final double windowEdgeLeftInset;
  final double windowEdgeRightInset;

  @override
  List<Object> get props => [windowEdgeLeftInset, windowEdgeRightInset];
}