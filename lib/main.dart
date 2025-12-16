import 'package:ekonomi_new/bloc/AddNewGoal/goal_list_bloc.dart';
import 'package:ekonomi_new/bloc/AddNewTransaction/transaction_list_bloc.dart';
import 'package:ekonomi_new/bloc/IncomeAllocation/IncomeAllocation_bloc.dart';
import 'package:ekonomi_new/bloc/Income_Onboard/IncomeBloc.dart';
import 'package:ekonomi_new/bloc/transaction/transaction_bloc.dart';
import 'package:ekonomi_new/screens/Registeration.dart';
import 'package:ekonomi_new/screens/onboarding_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<GoalListBloc>(create: (context) => GoalListBloc()),
        BlocProvider<TransactionListBloc>(
          create: (context) => TransactionListBloc(),
        ),
        BlocProvider<TransactionBloc>(create: (_) => TransactionBloc()),
        BlocProvider<IncomeBloc>(create: (_) => IncomeBloc()),
        BlocProvider<IncomeAllocationBloc>(
          create: (_) => IncomeAllocationBloc(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Registeration(),
        // body: AddNewDebt(),
      ),
      theme: ThemeData(primaryColor: Color(0xFF03969D)),
    );
  }
}
