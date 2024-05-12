import 'gtd_environment.dart';

class GtdEndpoint {
  // GTDEndpoints._();

  // // base url
  // static const String baseUrl = "https://uat-api.gotadi.com";

  // // recieveTimeout
  // static const int receiveTimeout = 30;

  // // connectTimeout
  // static const int connectTimeout = 30;

  GtdEnvironment env;
  String path;
  Map<String, dynamic>? params;
  late Uri uri;
  GtdEndpoint({required this.env, required this.path, bool hasScheme = true}) {
    if (hasScheme) {
      uri = Uri(scheme: "http", host: env.baseUrl, path: '/${env.platformPath}$path');
    } else {
      uri = Uri(scheme: "http", host: env.baseUrl, path: '/${env.platformPath}$path');
      // String url = '${env.baseUrl}/$path';
      // uri = Uri.parse(url);
    }
  }
}
