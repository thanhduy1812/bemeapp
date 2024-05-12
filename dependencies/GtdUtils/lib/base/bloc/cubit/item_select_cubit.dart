import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'item_select_state.dart';

class ItemSelectCubit extends Cubit<ItemSelectState> {
  ItemSelectCubit() : super(ItemSelectInitial());
  void rebuildWidget() {
    emit(ItemSelectInitial());
  }
}
