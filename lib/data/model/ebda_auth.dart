import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class EbdaAuth extends Equatable {
  final String accessToken;
  final String refreshToken;
  final String firebaseToken;

  EbdaAuth(
      {@required this.accessToken,
      @required this.refreshToken,
      @required this.firebaseToken});

  @override
  List<Object> get props => [accessToken, refreshToken, firebaseToken];
}
