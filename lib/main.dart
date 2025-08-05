import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/data/repositories/timer_repository.dart';
import 'app/router/app_router.dart';
import 'app/theme/app_theme.dart';
import 'app/ticker.dart';
import 'features/timers_list/bloc/timer_bloc.dart';

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
          const Ticker(),
        )..add(LoadTimers()),
        child: Builder(builder: (context) {
          final appRouter = AppRouter(context.read<TimerBloc>());
          return MaterialApp.router(
            title: 'Fleet Assignment',
            theme: AppTheme.light,
            routerConfig: appRouter.router,
          );
        }),
      ),
    );
  }
}
