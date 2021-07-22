import 'dart:convert';
import 'dart:io';

import 'package:customer/data/model/credentials.dart';
import 'package:customer/data/model/ebda_auth.dart';
import 'package:customer/data/source/ebda/ebda_service.dart';
import 'package:customer/util/parse_json_util.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'exception/api_exception.dart';
import 'exception/build_exception.dart';

extension EbdaServiceExtension on EbdaService {
  Future<Map<String, String>> buildContentTypeHeader() =>
      Future.value({HttpHeaders.contentTypeHeader: 'application/json'});

  Future<String> buildTokenRequestBody(Credentials credentials) async {
    try {
      return json.encode({
        'username': credentials.username,
        'password': credentials.password,
        'includeFirebaseToken': true
      });
    } catch (error) {
      throw BuildTokenRequestBodyException();
    }
  }

  Future<EbdaAuth> parseTokenResponse(Response response) async {
    if (response.statusCode == HttpStatus.ok) {
      return compute(parseJson, response.body).then((map) {
        final accessToken = map['access_token'];
        final refreshToken = map['refresh_token'];
        final firebaseToken = map['firebase_token'];

        return EbdaAuth(
            accessToken: accessToken,
            refreshToken: refreshToken,
            firebaseToken: firebaseToken);
      });
    } else {
      throw EbdaApiException(response.statusCode);
    }
  }
}
