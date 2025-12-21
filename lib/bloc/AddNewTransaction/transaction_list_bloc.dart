import 'package:flutter_bloc/flutter_bloc.dart';
import 'transaction_list_event.dart';
import 'transaction_list_state.dart';
class TransactionListBloc extends Bloc<TransactionListEvent, TransactionListState> {
  TransactionListBloc() : super(TransactionListState(transactions: [])) {
    on<AddTransactionEvent>((event, emit) {
      final updatedTransactions = List<Map<String, dynamic>>.from(state.transactions)
        ..add(event.transactionJson);
      emit(state.copyWith(transactions: updatedTransactions));
    });

    on<RemoveTransactionEvent>((event, emit) {
      final updatedTransactions = state.transactions
          .where((t) => t['id'] != event.transactionId)
          .toList();
      emit(state.copyWith(transactions: updatedTransactions));
    });

    on<UpdateAccountFilterEvent>((event, emit) {
      emit(state.copyWith(selectedAccountId: event.accountId));
    });

    on<UpdateDateFilterEvent>((event, emit) {
      emit(state.copyWith(selectedDateFilter: event.dateFilter));
    });
  }
}

