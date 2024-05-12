import 'package:gtd_utils/data/network/network.dart';
import 'package:gtd_utils/data/repositories/gtd_repository_error/gtd_error_rs.dart';
import 'package:gtd_utils/data/repositories/gtd_repository_error/gtd_error_constant.dart';
import 'package:collection/collection.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_tuple.dart';

class GtdApiError implements Exception {
  String message = "";
  String code = "";
  String localizeMessage = "";
  GtdApiError({this.message = "", this.code = "", this.localizeMessage = ""});
  GtdApiError.fromError({this.message = "", this.code = ""});

  GtdApiError.fromErrorRs(List<ErrorRs> errors) {
    List<GtdErrorConstant> errorConstants = errors
        .map((e) => GtdErrorConstant.findByCode(id: e.id, code: e.code))
        .where((element) => element != GtdErrorConstant.unknown)
        .toSet()
        .toList();
    GtdApiError apiError = fromErrorConstant(errorConstants.firstOrNull ?? GtdErrorConstant.unknown);
    message = apiError.message;
    code = apiError.code;
  }

  GtdApiError.fromErrorsJson(dynamic errors) {
    if (errors is List<ErrorRs>) {
      List<GtdErrorConstant> errorConstants = errors
          .map((e) => GtdErrorConstant.findByCode(id: e.id, code: e.code))
          .where((element) => element != GtdErrorConstant.unknown)
          .toSet()
          .toList();
      GtdApiError apiError = fromErrorConstant(errorConstants.firstOrNull ?? GtdErrorConstant.unknown);
      message = apiError.message;
      code = apiError.code;
    }
  }

  static GtdApiError handleObjectError(dynamic object) {
    if (object is GtdApiError) {
      Logger.e(object.message);
      return object;
    } else {
      Logger.e("Error unknown: $object");
      return fromErrorConstant(GtdErrorConstant.unknown);
    }
  }

  static GtdApiError fromErrorConstant(GtdErrorConstant errorConstant) {
    return GtdApiError(message: errorConstant.message, code: errorConstant.code);
  }

  Tuple<String, String> errorByCode({String code = "", String message = ""}) {
    switch (code) {
      // Error code int
      case "100":
        return Tuple(item1: code, item2: "Mật khẩu không đúng. Vui lòng thử lại");
      case "101":
        return Tuple(item1: code, item2: "Tài khoản đã được sử dụng");
      case "102":
        return Tuple(item1: code, item2: "EmailExist");
      case "103":
        return Tuple(item1: code, item2: "AuthenFail");
      case "104":
        return Tuple(item1: code, item2: "AccountNotExist");
      case "105":
        return Tuple(item1: code, item2: "AccountNotActive");
      case "106":
        return Tuple(item1: code, item2: "AccessExpire");
      case "107":
        return Tuple(item1: code, item2: "AccountExistButNotActived");
      case "108":
        return Tuple(item1: code, item2: "FillInfor");
      case "109":
        return Tuple(item1: code, item2: "ErrorSocialAccount");
      case "1101":
        return Tuple(item1: code, item2: "PhoneExist");
      case "1104":
        return Tuple(item1: code, item2: "AccountNotExist");
      case "2103":
        return Tuple(item1: code, item2: "IncorrectOTP");
      case "3012":
        return Tuple(item1: code, item2: "AccountIsDeleted");
      case "4001":
        return Tuple(item1: code, item2: "Gotadi_AccountNotExist");
      case "4002":
        return Tuple(item1: code, item2: "Tài khoản không tồn tại");
      case "4003":
        return Tuple(item1: code, item2: "Loại tài khoản không được phép đăng nhập");
      case "4004":
        return Tuple(item1: code, item2: "Tài khoản chưa được kích hoạt");
      case "4012":
        return Tuple(item1: code, item2: "AccountIsDeleted");
      case "4005":
        return Tuple(item1: code, item2: "Mật khẩu không chính xác, vui lòng kiểm tra lại");
      case "4006":
        return Tuple(item1: code, item2: "Email đã tồn tại");
      case "4007":
        return Tuple(item1: code, item2: "Tài khoản đã tồn tại");
      case "4008":
        return Tuple(item1: code, item2: "Số điện thoại đã được sử dụng");
      case "6969":
        return Tuple(item1: code, item2: "Tài khoản của bạn không đủ để thực hiện thanh toán này. Vui lòng thử lại");
      case "Error_Common":
        return Tuple(item1: code, item2: "Đã có lỗi xảy ra, vui lòng thử lại sau giây lát.");
      default:
        return Tuple(item1: "-1", item2: message);
    }
  }
}
