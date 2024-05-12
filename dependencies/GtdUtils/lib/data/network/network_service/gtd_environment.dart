// ignore: constant_identifier_names
enum GTDEnvType { BmeEnglish }

class GtdEnvironment {
  GTDEnvType env;
  late String baseUrl;
  late String platformPath;
  late Map<String, String> headers;
  GtdEnvironment({this.env = GTDEnvType.BmeEnglish}) {
    platformPath = "";
    switch (env) {
      case GTDEnvType.BmeEnglish:
        baseUrl = "beme.io.vn";
        platformPath = "";
        headers = {};
        // headers = {
        //   'Access-Control-Request-Headers': 'access-control-allow-origin',
        //   'Origin': 'http://localhost:8888',
        // };
        break;

      default:
        baseUrl = "beme.io.vn";
    }
  }
}
