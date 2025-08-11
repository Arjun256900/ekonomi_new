class SpendingState {
  final String amount;
  final String date;
  final String notes;
  final String filepath;
  final bool isValid;
  SpendingState({
    required this.amount,
    required this.date,
    required this.filepath,
    required this.notes,
    required this.isValid,
  });
  factory SpendingState.initial(){
    return SpendingState(amount: '', date: '', filepath: '', notes: '',isValid:false);
  }
  SpendingState copyWith({
    String? amount,
    String? date,
    String? filepath,
    String? notes,
    bool? isValid,
  }){
    return SpendingState(amount: amount ?? this.amount, date: date ?? this.date, filepath: filepath ?? this.filepath, notes: notes ?? this.notes, isValid: isValid ?? this.isValid);
  }
  Map<String,dynamic> toJson(){
    return {
      "amount" : amount,
      "date" : date,
      "filepath" : filepath,
      "notes" : notes,
    };
  }
}