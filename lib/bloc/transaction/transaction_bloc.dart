import '../AddNewTransaction/transaction_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekonomi_new/bloc/transaction/transaction_event.dart';
import 'package:ekonomi_new/bloc/transaction/transaction_state.dart';

import 'package:intl/intl.dart';
import '../AddNewTransaction/transaction_list_event.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionState.initial()) {
    on<DebitOrCreditChanged>((event, emit) {
      // emit(state.copyWith(debitOrCredit: event.value, isValid: _formIsValid(newState)));
    });

    on<AmountChanged>((event, emit) {
      emit(state.copyWith(amount: event.value));
    });

    on<DateChanged>((event, emit) {
      emit(state.copyWith(date: event.value));
    });

    on<SourceSelectionChanged>((event, emit) {
      emit(state.copyWith(sourceSelection: event.value));
    });

    on<CategoryChanged>((event, emit) {
      emit(state.copyWith(category: event.value));
    });

    on<FilepathChanged>((event, emit) {
      emit(state.copyWith(filepath: event.value));
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

        print(transactionJson);
      } else {
        print("Form is not valid.");
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
