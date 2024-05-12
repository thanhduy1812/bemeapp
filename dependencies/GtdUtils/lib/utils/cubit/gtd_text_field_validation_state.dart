// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'gtd_text_field_validation_cubit.dart';

abstract class GtdTextFieldValidationState extends Equatable {
  final bool isValid;
  final bool focusTextField = false;
  final String errorMess;
  const GtdTextFieldValidationState(this.isValid, this.errorMess);

  @override
  List<Object> get props => [isValid, errorMess];

  GtdTextFieldValidationCubitInitial copyWith({
    bool? isValid,
    String? errorMess,
  }) {
    return GtdTextFieldValidationCubitInitial(
      isValid ?? this.isValid,
      errorMess ?? this.errorMess,
    );
  }
}

class GtdTextFieldValidationCubitInitial extends GtdTextFieldValidationState {
  const GtdTextFieldValidationCubitInitial(super.isValid, super.errorMess);
}

class GtdTextFieldValidationResetState extends GtdTextFieldValidationState {
  const GtdTextFieldValidationResetState(super.isValid, super.errorMess);
}
