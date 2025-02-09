part of 'validate_bloc.dart';

class ValidateEvent extends Equatable {
  const ValidateEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ValidateNumber extends ValidateEvent {
  final String? number;
  const ValidateNumber(this.number);
  @override
  List<Object?> get props => [number];
}
