import 'package:ekonomi_new/bloc/AddNewGoal/goal_list_bloc.dart';
import 'package:ekonomi_new/bloc/AddNewTransaction/transaction_list_bloc.dart';
import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAllocation_bloc.dart';
import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAlllocation_Events.dart';
import 'package:ekonomi_new/bloc/Income_Onboard/IncomeBloc.dart';
import 'package:ekonomi_new/bloc/transaction/transaction_bloc.dart';
import 'package:ekonomi_new/screens/Registeration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<GoalListBloc>(
          create: (_) => GoalListBloc(),
        ),

        BlocProvider<TransactionListBloc>(
          create: (_) => TransactionListBloc(),
        ),

        BlocProvider<TransactionBloc>(
          create: (_) => TransactionBloc(),
        ),

        BlocProvider<IncomeBloc>(
          create: (_) => IncomeBloc(),
        ),

        /// ✅ FIXED: Load defaults ONCE here
        BlocProvider<IncomeAllocationBloc>(
          create: (context) {
            final bloc = IncomeAllocationBloc();

            final totalIncome =
                context.read<IncomeBloc>().state.totalIncome;

            bloc.add(
              LoadDefaultAllocations(
                totalIncome: totalIncome,
              ),
            );

            return bloc;
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color(0xFF03969D)),
      home: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Registeration(),
      ),
    );
  }
}
