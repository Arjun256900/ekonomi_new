import 'package:ekonomi_new/bloc/Income_Onboard/IncomeEvent.dart';
import 'package:ekonomi_new/bloc/Income_Onboard/IncomeState.dart';
import 'package:ekonomi_new/models/IncomeModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  IncomeBloc() : super(IncomeState(incomes: [])) {
    on<AddIncomeSource>((event, emit) {
      emit(
        IncomeState(
          incomes: List.from(state.incomes)..add(event.source),
        ),
      );
    });

    on<UpdateIncomeSource>((event, emit) {
      final updated = List<IncomeSource>.from(state.incomes);
      updated[event.index] = event.updatedSource;
      emit(IncomeState(incomes: updated));
    });

    on<DeleteIncomeSource>((event, emit) {
      final updated = List<IncomeSource>.from(state.incomes)
        ..removeAt(event.index);
      emit(IncomeState(incomes: updated));
    });
  }
}
