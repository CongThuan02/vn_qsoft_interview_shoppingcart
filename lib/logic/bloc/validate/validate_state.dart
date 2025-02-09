part of 'validate_bloc.dart';

class ValidateState extends Equatable {
  final String? message;
  final bool? isError;

  const ValidateState({this.message, this.isError = false});

  ValidateState copyWith({
    final String? message,
    final bool? isError,
  }) {
    return ValidateState(
      message: message ?? this.message,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [message, isError];
}
