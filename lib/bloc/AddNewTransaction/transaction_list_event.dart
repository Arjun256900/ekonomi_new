abstract class TransactionListEvent {}

class AddTransactionEvent extends TransactionListEvent {
  final Map<String, dynamic> transactionJson;
  AddTransactionEvent(this.transactionJson);
}

class RemoveTransactionEvent extends TransactionListEvent {
  final String transactionId;
  RemoveTransactionEvent(this.transactionId);
}

class UpdateAccountFilterEvent extends TransactionListEvent {
  final String accountId;
  UpdateAccountFilterEvent(this.accountId);
}

class UpdateDateFilterEvent extends TransactionListEvent {
  final String dateFilter;
  UpdateDateFilterEvent(this.dateFilter);
}
