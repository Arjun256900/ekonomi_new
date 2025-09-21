import 'package:ekonomi_new/bloc/Global/Spendings_bloc.dart';
import 'package:ekonomi_new/bloc/Global/savingsGlobal.dart';

import '../AddNewTransaction/transaction_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekonomi_new/bloc/transaction/transaction_event.dart';
import 'package:ekonomi_new/bloc/transaction/transaction_state.dart';
import 'package:intl/intl.dart';
import '../AddNewTransaction/transaction_list_event.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionState.initial()) {
    on<DebitOrCreditChanged>((event, emit) {
      final newState = state.copyWith(debitOrCredit: event.value);
      emit(newState.copyWith(isValid: _formIsValid(newState)));
    });

    on<AmountChanged>((event, emit) {
      final newState = state.copyWith(amount: event.value);
      emit(newState.copyWith(isValid: _formIsValid(newState)));
    });

    on<DateChanged>((event, emit) {
      final newState = state.copyWith(date: event.value);
      emit(newState.copyWith(isValid: _formIsValid(newState)));
    });

    on<SourceSelectionChanged>((event, emit) {
      final newState = state.copyWith(sourceSelection: event.value);
      emit(newState.copyWith(isValid: _formIsValid(newState)));
    });

    on<CategoryChanged>((event, emit) {
      final newState = state.copyWith(category: event.value);
      emit(newState.copyWith(isValid: _formIsValid(newState)));
    });

    on<FilepathChanged>((event, emit) {
      final newState = state.copyWith(filepath: event.value);
      emit(newState.copyWith(isValid: _formIsValid(newState)));
    });
    on<UndoTransaction>((event, emit) {
      emit(
        state.copyWith(
          debitOrCredit: '',
          amount: '',
          date: '',
          sourceSelection: '',
          category: '',
          filepath: '',
        ),
      );
    });
    on<SubmitTransaction>((event, emit) {
      if (_formIsValid(state)) {
        final transactionJson = state.toJson();

        final now = DateTime.now();
        transactionJson['time'] = DateFormat('h a').format(now);

        DateTime parsedDate;
        try {
          parsedDate = DateFormat('dd/MM/yyyy').parse(state.date);
        } catch (_) {
          parsedDate = now; // fallback
        }
        print(parsedDate);

        transactionJson['date'] = DateFormat('MMM d').format(parsedDate);

        event.context.read<TransactionListBloc>().add(
          AddTransactionEvent(transactionJson),
        );
        if (transactionJson['debitOrCredit'] == "Debit") {
          SpendingsGlobal().addTransaction(transactionJson);
        } else {
          SavingsGlobal().addSaving(transactionJson);
        }

        print(transactionJson);
      } else {
        print("Form is not valid.");
      }
    });

    // NEW: handle adding 10 dummy transactions
    on<AddTransaction>((event, emit) {
      // Add to TransactionListBloc
      event.context.read<TransactionListBloc>().add(
        AddTransactionEvent(event.transaction),
      );

      // Update Spendings or Savings
      if (event.transaction['debitOrCredit'] == "Debit") {
        SpendingsGlobal().addTransaction(event.transaction);
      } else {
        SavingsGlobal().addSaving(event.transaction);
      }
    });
  }

  bool _formIsValid(TransactionState s) {
    return s.debitOrCredit.isNotEmpty &&
        s.amount.isNotEmpty &&
        s.date.isNotEmpty &&
        s.sourceSelection.isNotEmpty &&
        s.category.isNotEmpty &&
        s.filepath.isNotEmpty;
  }
}
