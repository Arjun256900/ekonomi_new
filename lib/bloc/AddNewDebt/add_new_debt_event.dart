abstract class AddNewDebtEvent {}

class LoanTypeChanged extends AddNewDebtEvent {
  final String loanType;
  LoanTypeChanged(this.loanType);
}

class LenderNameChanged extends AddNewDebtEvent {
  final String lenderName;
  LenderNameChanged(this.lenderName);
}

class LoanAmountChanged extends AddNewDebtEvent {
  final double loanAmount;
  LoanAmountChanged(this.loanAmount);
}

class InterestRateChanged extends AddNewDebtEvent {
  final double interestRate;
  InterestRateChanged(this.interestRate);
}

class StartDateChanged extends AddNewDebtEvent {
  final String startDate;
  StartDateChanged(this.startDate);
}

class EndDateChanged extends AddNewDebtEvent {
  final String endDate;
  EndDateChanged(this.endDate);
}

class FormSubmitted extends AddNewDebtEvent {}

class FormReset extends AddNewDebtEvent {}
