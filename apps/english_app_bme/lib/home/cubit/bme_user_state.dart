part of 'bme_user_cubit.dart';

@immutable
sealed class BmeUserState extends Equatable {}

final class BmeUserInitial extends BmeUserState {
  final List<BmeUser> bmeUsers;

  BmeUserInitial({required this.bmeUsers});

  @override
  List<Object?> get props => bmeUsers;
}

final class BmeUserLoading extends BmeUserState {
  @override
  List<Object?> get props => [UniqueKey()];
}

final class BmeUserError extends BmeUserState {
  @override
  List<Object?> get props => [UniqueKey()];
}
