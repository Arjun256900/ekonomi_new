import 'package:ekonomi_new/bloc/AddNewGoal/goal_list_bloc.dart';
import 'package:ekonomi_new/bloc/AddNewTransaction/transaction_list_bloc.dart';
import 'package:ekonomi_new/screens/chatbot_screen.dart';
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
        // body: OnboardingScreen(),
        body: Chatbot(),
      ),
      theme: ThemeData(primaryColor: Color(0xFF03969D)),
    );
  }
}
