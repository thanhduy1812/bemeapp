import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gtd_utils/data/repositories/gtd_repository_error/gtd_api_error.dart';

part 'base_delegate_state.dart';

class BaseDelegateCubit extends Cubit<BaseDelegateState> {
  BaseDelegateCubit() : super(BaseDelegateInitial());
}
