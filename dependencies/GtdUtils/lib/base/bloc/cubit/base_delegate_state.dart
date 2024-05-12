part of 'base_delegate_cubit.dart';

/// Handle behavior of client
abstract class BaseDelegateState extends Equatable {
  // final GtdApiError? apiError;
  // BaseDelegateState({this.apiError}) {
  //   print(apiError ?? "nothing");
  // }
  @override
  List<Object> get props => [];
}

class BaseDelegateInitial extends BaseDelegateState {}

class BaseNetworkState extends BaseDelegateState {
  late final GtdApiError apiError;
  BaseNetworkState({required this.apiError});
  @override
  List<Object> get props => [apiError];
}