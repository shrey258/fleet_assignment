import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/timer_bloc.dart';
import '../widgets/timer_list_item.dart';

class TimersListScreen extends StatelessWidget {
  const TimersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/create'),
          ),
        ],
      ),
      body: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          if (state is TimerLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TimerLoadSuccess) {
            return ListView.builder(
              itemCount: state.timers.length,
              itemBuilder: (context, index) {
                final timer = state.timers[index];
                return TimerListItem(timer: timer);
              },
            );
          }
          if (state is TimerLoadFailure) {
            return Center(child: Text('Failed to load timers: ${state.message}'));
          }
          return const Center(child: Text('No timers found.'));
        },
      ),
    );
  }
}
