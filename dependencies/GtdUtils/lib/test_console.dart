import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

void main(List<String> args) {
  var key = utf8.encode('Gotadi');
  var bytes = utf8.encode("HANSGN03-15-202303-16-2023EROUNDTRIP100020001678722109939");

  var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
  var digest = hmacSha256.convert(bytes);
  String base64 = base64Encode(digest.bytes);

  // String dateTest = "2023-03-15 10:36:14 UTC";
  // String dateUTC = "2023-03-13T15:41:49.939Z";
  // DateTime date = DateFormat("yyyy-MM-dd HH:mm:ss").parseUTC(dateTest);
  // DateTime date = DateFormat('yyyy-MM-ddTHH:mm:ssZ').parseUTC(dateUTC);
  // DateTime date = DateTime.parse(dateUTC);
  // print(date);
  // print(date.millisecondsSinceEpoch);
  // print("HMAC digest as bytes: ${digest.bytes}");
  // print("HMAC digest as hex string: $base64");
}
//Time: 2023-03-15 15:02:29 - 1678722109939
//Base64: YeUyfWOQSlaQRBrdXEhVV6jpI/qp50W1kBJrzx6C5HE=
//TimeStamp: 1678876336122 / 1678876574514 - 2023-03-15 10:36:14
//PlainString: HANSGN03-15-202303-16-2023EROUNDTRIP111020001678723808167

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  if (kDebugMode) {
    print('--- Parse json from: $assetsPath');
  }
  return rootBundle.loadString(assetsPath).then((jsonStr) => jsonDecode(jsonStr));
}
