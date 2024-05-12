import 'package:flutter/material.dart';
import 'package:gtd_utils/constants/app_const.dart';
import 'package:gtd_utils/data/configuration/gtd_app_config.dart';
import 'package:gtd_utils/data/network/network.dart';

abstract class BaseViewModel with ChangeNotifier {
  GtdAppSupplier supplier = AppConst.shared.appScheme.appSupplier;
  bool hasPayment = AppConst.shared.appScheme.hasPayment;
  @override
  void dispose() {
    super.dispose();
    Logger.i("$runtimeType is denied");
  }
}

// class BaseViewModelCodec extends MessageCodec<BaseViewModel> {
//   @override
//   BaseViewModel? decodeMessage(ByteData? message) {
//     if (message == null) {
//       return null;
//     }
//     return BaseViewModel();
//   }

//   @override
//   ByteData? encodeMessage(BaseViewModel message) {
//     return ByteData(0);
//   }
// }

// class BaseViewModelCodec extends Codec<BaseViewModel, BaseViewModel> {
//   @override
//   Converter<BaseViewModel, BaseViewModel> get decoder => BaseViewModelConverter();

//   @override
//   Converter<BaseViewModel, BaseViewModel> get encoder => BaseViewModelConverter();
// }

// class BaseViewModelConverter extends Converter<BaseViewModel, BaseViewModel> {
//   @override
//   BaseViewModel convert(BaseViewModel input) {
//     return input;
//   }
// }

class CardViewModel extends BaseViewModel {
  double width;
  double height;
  CardViewModel({
    required this.width,
    required this.height,
  });
}
