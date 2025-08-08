import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekonomi_new/bloc/transaction/transaction_event.dart';
import 'package:ekonomi_new/bloc/transaction/transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionState.initial()) {
    on<DebitOrCreditChanged>((event, emit) {
      emit(state.copyWith(debitOrCredit: event.value));
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
      emit(state.copyWith(
    debitOrCredit: '',
    amount: '',
    date: '',
    sourceSelection: '',
    category: '',
    filepath: '',
  ));
    });
    on<SubmitTransaction>((event, emit) {
      if (_formIsValid(state)) {
        print(state.toJson());
        // Optionally: emit success state or trigger listener
      } else {
        print("Form is not valid.");
        // emit(state.copyWith());
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
