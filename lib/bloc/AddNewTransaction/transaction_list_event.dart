abstract class TransactionListEvent {}

class AddTransactionEvent extends TransactionListEvent {
  final Map<String, dynamic> transactionJson;
  AddTransactionEvent(this.transactionJson);
}

class RemoveTransactionEvent extends TransactionListEvent {
  final String transactionId;
  RemoveTransactionEvent(this.transactionId);
}
