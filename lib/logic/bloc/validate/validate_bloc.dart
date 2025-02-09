import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'validate_event.dart';
part 'validate_state.dart';

class ValidateBloc extends Bloc<ValidateEvent, ValidateState> {
  ValidateBloc() : super(const ValidateState()) {
    on<ValidateEvent>(_onValidateNumber);
  }

  void _onValidateNumber(ValidateEvent event, Emitter<ValidateState> emit) {
    if (event is ValidateNumber) {
      if (event.number!.isEmpty) {
        emit(state.copyWith(
          message: 'Quantity cannot null',
          isError: true,
        ));
      } else {
        int number = int.parse(event.number!);
        number < 1
            ? emit(state.copyWith(isError: true, message: 'Quantity cannot less than 1'))
            : number > 999
                ? emit(state.copyWith(isError: true, message: 'Quantity cannot more than 999'))
                : emit(state.copyWith(isError: false, message: null));
      }
    }
  }
}
