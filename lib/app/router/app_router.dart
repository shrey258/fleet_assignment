import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/create_timer/view/create_timer_screen.dart';
import '../../features/task_details/view/task_details_screen.dart';
import '../../features/timers_list/bloc/timer_bloc.dart';
import '../../features/timers_list/view/timers_list_screen.dart';

class AppRouter {
  final TimerBloc timerBloc;

  AppRouter(this.timerBloc);

  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const TimersListScreen(),
        routes: <GoRoute>[
          GoRoute(
            path: 'create',
            builder: (BuildContext context, GoRouterState state) => const CreateTimerScreen(),
          ),
          GoRoute(
            path: 'task/:taskId',
            builder: (BuildContext context, GoRouterState state) {
              final taskId = state.pathParameters['taskId']!;
              final timerState = timerBloc.state;

              if (timerState is TimerLoadSuccess) {
                final task = timerState.tasks.firstWhere((t) => t.id == taskId);
                final project = timerState.projects.firstWhere((p) => p.id == task.projectId);
                return TaskDetailsScreen(project: project, task: task);
              }
              // Fallback or loading screen
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            },
          ),
        ],
      ),
    ],
  );
}
