import 'dart:convert';

class JsonCodeable {
  // T fromJson(String json) => T
  static T fromJson<T extends GTDJsonModel>(String json) {
    T model = jsonDecode(json);
    return model;
  }

  // static T fromMap<T extends GTDJsonModel>(Map<String, dynamic> map) {
  //   // T model = jsonDecode(map);
  //   return model;
  // }

  // static String toJson<T extends GTDJsonModel>(T data) {
  //   String json = jsonEncode(data.toMap());
  //   return json;
  // }
}

// class BaseResponse<T> {
//   int code;
//   String message;
//   T responseObject;

//   BaseResponse._fromJson(Map<String, dynamic> parsedJson)
//       : code = parsedJson['Code'],
//         message = parsedJson['Message'];

//   factory BaseResponse.fromJson(Map<String, dynamic> json) {
//     if (T == int) {
//       return IntResponse.fromJson(json) as BaseResponse<T>;
//     }
//     throw UnimplementedError();
//   }
// }

class GTDJsonModel {
  // GTDJsonModel fromJson(Map<String, dynamic> json) {}
  // GTDJsonModel fromJson(String json) {
  //   GTDJsonModel model = JsonCodeable.fromJson(json);
  //   return model;
  // }

  // Map<String, dynamic> toJson() {
  //   String json = jsonEncode(this);
  //   return json;
  // }
  // GTDJsonModel();
  // factory GTDJsonModel.fromJson(Map<String, dynamic> json) {
  // MARK: implement GTDJsonModel.fromJson
  //   throw UnimplementedError();
  // }
  // GTDJsonModel fromJson(Map<String, dynamic> map);
  // @override
  // Map<String, dynamic> toMap();
  String logJson({String tag = ""}) {
    const encoder = JsonEncoder.withIndent('  ');
    final prettyString = encoder.convert(this);
    return prettyString;
  }
}
