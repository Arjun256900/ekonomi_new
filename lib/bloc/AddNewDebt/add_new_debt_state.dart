class AddNewDebtState {
  final String loanType;
  final String lenderName;
  final double loanAmount;
  final double interestRate;
  final String? startDate;
  final String? endDate;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const AddNewDebtState({
    this.loanType = '',
    this.lenderName = '',
    this.loanAmount = 0.0,
    this.interestRate = 0.0,
    this.startDate,
    this.endDate,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  AddNewDebtState copyWith({
    String? loanType,
    String? lenderName,
    double? loanAmount,
    double? interestRate,
    String? startDate,
    String? endDate,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return AddNewDebtState(
      loanType: loanType ?? this.loanType,
      lenderName: lenderName ?? this.lenderName,
      loanAmount: loanAmount ?? this.loanAmount,
      interestRate: interestRate ?? this.interestRate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  bool get isValid =>
      loanType.isNotEmpty &&
      lenderName.isNotEmpty &&
      loanAmount > 0 &&
      interestRate > 0 &&
      startDate != null &&
      endDate != null;

  Map<String, dynamic> toJson() {
    return {
      "loanType": loanType,
      "lenderName": lenderName,
      "loanAmount": loanAmount,
      "interestRate": interestRate,
      "startDate": startDate,
      "endDate": endDate,
      "isSubmitting": isSubmitting,
      "isSuccess": isSuccess,
      "isFailure": isFailure,
    };
  }
}
