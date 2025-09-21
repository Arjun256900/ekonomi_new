import 'package:ekonomi_new/bloc/AddNewSpending/spending_event.dart';
import 'package:ekonomi_new/bloc/AddNewSpending/spending_state.dart';
import 'package:ekonomi_new/bloc/Global/Spendings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class SpendingBloc extends Bloc<SpendingEvent, SpendingState> {
  SpendingBloc() : super(SpendingState.initial()) {
    on<AmountChanged>((event, emit) {
      final newState = state.copyWith(amount: event.value);
      emit(newState.copyWith(isValid: _formIsValid(newState)));
    });
    on<DateChanged>((event, emit) {
      final newState = state.copyWith(date: event.value);
      emit(newState.copyWith(isValid: _formIsValid(newState)));
    });
    on<NotesChanged>((event, emit) {
      final newState = state.copyWith(notes: event.value);
      emit(newState.copyWith(isValid: _formIsValid(newState)));
    });
    on<FilepathChanged>((event, emit) {
      final newState = state.copyWith(filepath: event.value);
      emit(newState.copyWith(isValid: _formIsValid(newState)));
    });
    on<UndoSpending>((event, emit) {
      emit(state.copyWith(amount: '', date: '', notes: '', filepath: ''));
    });
    on<SubmitSpending>((event, emit) {
      if (_formIsValid(state)) {
        final spendingJson = state.toJson();

        final now = DateTime.now();

        DateTime parsedDate;
        try {
          parsedDate = DateFormat('dd/MM/yyyy').parse(state.date);
        } catch (_) {
          parsedDate = now;
        }

        spendingJson['date'] = DateFormat('MMM d').format(parsedDate);

        
        // SpendingsGlobal().addSpending(spendingJson);

        print("Spending Added: $spendingJson");

        // Example: If you also have TransactionListBloc state here:
        // final transactions = context.read<TransactionListBloc>().state.transactions;
        // print("Global Sum: ${GlobalRepository().calculateTotalSum(transactions)}");

        emit(SpendingState.initial()); // Reset form
      } else {
        print("Form is not valid.");
      }
    });

  }
  bool _formIsValid(SpendingState s) {
    return s.amount.isNotEmpty &&
        s.date.isNotEmpty &&
        s.notes.isNotEmpty &&
        s.filepath.isNotEmpty;
  }
}
