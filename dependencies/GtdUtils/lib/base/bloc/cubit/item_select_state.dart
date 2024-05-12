part of 'item_select_cubit.dart';

abstract class ItemSelectState extends Equatable {
  const ItemSelectState();

  @override
  List<Object> get props => [UniqueKey()];
}

class ItemSelectInitial extends ItemSelectState {}
