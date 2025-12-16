import 'package:ekonomi_new/models/IncomeModel.dart';

abstract class IncomeEvent {}

class AddIncomeSource extends IncomeEvent {
  final IncomeSource source;
  AddIncomeSource(this.source);
}
class UpdateIncomeSource extends IncomeEvent {
  final int index;
  final IncomeSource updatedSource;

  UpdateIncomeSource(this.index, this.updatedSource);
}

class DeleteIncomeSource extends IncomeEvent {
  final int index;
  DeleteIncomeSource(this.index);
}