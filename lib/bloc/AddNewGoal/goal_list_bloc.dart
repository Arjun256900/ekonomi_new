import 'package:flutter_bloc/flutter_bloc.dart';
import 'goal_list_event.dart';
import 'goal_list_state.dart';

class GoalListBloc extends Bloc<GoalListEvent, GoalListState> {
  GoalListBloc() : super(GoalListState(goals: [])) {
    on<AddGoalEvent>((event, emit) {
      final updatedGoals = List<Map<String, dynamic>>.from(state.goals)
        ..add(event.goalJson);
      emit(state.copyWith(goals: updatedGoals));
    });

    on<RemoveGoalEvent>((event, emit) {
      final updatedGoals = state.goals.where((g) => g['id'] != event.goalId).toList();
      emit(state.copyWith(goals: updatedGoals));
    });
  }
}
