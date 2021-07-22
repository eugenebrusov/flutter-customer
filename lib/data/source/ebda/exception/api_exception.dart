
import 'dart:io';

class EbdaApiException implements Exception {
  final int status;

  EbdaApiException(this.status);
}