import 'package:equatable/equatable.dart';
import 'package:gtd_utils/base/view_model/base_view_model.dart';

abstract class ItemSelectVM<T> extends BaseViewModel implements EquatableMixin {
  bool isSelected = false;
  T data;
  ItemSelectVM({
    this.isSelected = false,
    required this.data,
  });
  void toggle() {
    isSelected = !isSelected;
  }

  @override
  List<Object?> get props => [data];

  @override
  bool? get stringify => true;

  String get itemTitle => "data";

  String get itemSubTitle => "";
}

class TitleItemSelectVM extends ItemSelectVM<String> {
  TitleItemSelectVM({required super.data});
}
