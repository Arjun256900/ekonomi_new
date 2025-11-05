import 'package:ekonomi_new/bloc/AddNewDebt/add_new_debt_event.dart';
import 'package:ekonomi_new/bloc/AddNewDebt/add_new_debt_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddNewDebtBloc extends Bloc<AddNewDebtEvent, AddNewDebtState> {
  AddNewDebtBloc() : super(const AddNewDebtState()) {
    on<LoanTypeChanged>((event, emit) {
      emit(state.copyWith(loanType: event.loanType));
    });

    on<LenderNameChanged>((event, emit) {
      emit(state.copyWith(lenderName: event.lenderName));
    });

    on<LoanAmountChanged>((event, emit) {
      emit(state.copyWith(loanAmount: event.loanAmount));
    });

    on<InterestRateChanged>((event, emit) {
      emit(state.copyWith(interestRate: event.interestRate));
    });

    on<StartDateChanged>((event, emit) {
      emit(state.copyWith(startDate: event.startDate));
    });

    on<EndDateChanged>((event, emit) {
      emit(state.copyWith(endDate: event.endDate));
    });

    on<FormSubmitted>((event, emit) async {
      if (!state.isValid) {
        emit(state.copyWith(isFailure: true));
        return;
      }
      emit(state.copyWith(isSubmitting: true, isFailure: false));
      await Future.delayed(const Duration(seconds: 1)); // simulate API call
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    });

    on<FormReset>((event, emit) {
      emit(const AddNewDebtState());
    });
  }
}
