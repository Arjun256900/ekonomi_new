import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_event_event.dart';
import 'add_event_state.dart';
import 'dart:convert';

class AddEventBloc extends Bloc<AddEventEvent, AddEventState> {
  AddEventBloc() : super(const AddEventState()) {
    on<TitleChanged>((event, emit) {
      emit(state.copyWith(title: event.title));
    });

    on<DateChanged>((event, emit) {
      emit(state.copyWith(date: event.date));
    });

    on<BudgetChanged>((event, emit) {
      emit(state.copyWith(budget: event.budget));
    });

    on<SavingStrategyChanged>((event, emit) {
      emit(state.copyWith(strategy: event.strategy));
    });

    on<LinkToGoalChanged>((event, emit) {
      emit(state.copyWith(linkToGoal: event.option));
    });

    on<ReminderToggled>((event, emit) {
      emit(state.copyWith(isReminderSelected: !state.isReminderSelected));
    });

    on<SaveEventPressed>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));

      if (_formIsValid(state)) {
        // You can save to API or database here
        print(jsonEncode(state.toJson()));
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else {
        print("Form is not valid.");
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });
  }

  bool _formIsValid(AddEventState s) {
    return s.budget.isNotEmpty &&
        s.date != null &&
        s.linkToGoal != null &&
        s.linkToGoal!.isNotEmpty &&
        s.title.isNotEmpty &&
        s.strategy.isNotEmpty;
  }
}
