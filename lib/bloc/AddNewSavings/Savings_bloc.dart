import 'package:ekonomi_new/bloc/AddNewSavings/Savings_State.dart';
import 'package:ekonomi_new/bloc/AddNewSavings/Savings_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavingsBloc extends Bloc<SavingsEvent, SavingsState> {
  SavingsBloc() : super(SavingsState()) {
    on<AmountChanged>((event, emit) {
      emit(state.copyWith(amount: event.amount, saved: false));
    });

    on<DateChanged>((event, emit) {
      emit(state.copyWith(date: event.date, saved: false));
    });

    on<CategoryChanged>((event, emit) {
      emit(state.copyWith(Category: event.value, saved: false));
    });

    on<PaymentChanged>((event, emit) {
      emit(state.copyWith(Payment: event.value, saved: false));
    });

    on<UndoForm>((event, emit) {
      emit(SavingsState());
    });

    on<SaveForm>((event, emit) {
      final json = {
        "amount": state.amount,
        "date": state.date,
        "dropdown1": state.Category,
        "dropdown2": state.Payment,
      };
      emit(state.copyWith(saved: true, jsonResult: json));
    });
  }
}
