import 'package:fleet_assignment/app/data/repositories/timer_repository.dart';
import 'package:fleet_assignment/app/theme/app_theme.dart';
import 'package:fleet_assignment/features/timers_list/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fleet_assignment/features/timers_list/view/timers_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TimerRepository(),
      child: BlocProvider(
        create: (context) => TimerBloc(
          RepositoryProvider.of<TimerRepository>(context),
        )..add(LoadTimers()),
        child: MaterialApp(
          title: 'Fleet Assignment',
          theme: AppTheme.light,
          home: const TimersListScreen(),
        ),
      ),
    );
  }
}
