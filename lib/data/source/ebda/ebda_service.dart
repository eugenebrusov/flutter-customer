import 'package:customer/data/model/credentials.dart';
import 'package:customer/data/model/ebda_auth.dart';
import 'package:http/http.dart';

import 'package:customer/data/source/ebda/ebda_service_extension.dart';

class EbdaService {
  Future<EbdaAuth> authenticate(Credentials credentials) =>
      buildContentTypeHeader().then((headers) {
        return buildTokenRequestBody(credentials).then((body) {
          return post('https://api.catalyst.com.sa/oauth/token', headers: headers, body: body);
        });
      }).then((response) {
        return parseTokenResponse(response);
      });
}
