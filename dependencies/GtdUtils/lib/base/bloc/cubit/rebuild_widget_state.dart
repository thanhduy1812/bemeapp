part of 'rebuild_widget_cubit.dart';

abstract class RebuildWidgetState extends Equatable {
  const RebuildWidgetState();

  @override
  List<Object> get props => [UniqueKey()];
}

class RebuildWidgetInitial extends RebuildWidgetState {}

class RebuildWidgetAppBar extends RebuildWidgetState {}

class RebuildWidgetBody extends RebuildWidgetState {}

class RebuildWidgetBottom extends RebuildWidgetState {}

class RebuildWidgetUnique extends RebuildWidgetState {
  final dynamic data;

  const RebuildWidgetUnique(this.data);
  @override
  List<Object> get props => [data];
}
