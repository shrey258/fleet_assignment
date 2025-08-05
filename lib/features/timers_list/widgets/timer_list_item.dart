import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/data/models/project_model.dart';
import '../../../app/data/models/task_model.dart';
import '../../../app/data/models/timer_model.dart';
import 'package:go_router/go_router.dart';
import '../bloc/timer_bloc.dart';

class TimerListItem extends StatelessWidget {
  final TimerModel timer;

  const TimerListItem({super.key, required this.timer});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TimerBloc>();
    final state = bloc.state;

    if (state is! TimerLoadSuccess) {
      // This should not happen if the list is built correctly,
      // but as a fallback, we can show a placeholder.
      return const SizedBox.shrink();
    }

    final project = state.projects.firstWhere(
      (p) => p.id == timer.projectId,
      orElse: () => ProjectModel(id: '', name: 'Unknown'),
    );
    final task = state.tasks.firstWhere(
      (t) => t.id == timer.taskId,
      orElse: () => TaskModel(id: '', name: 'Unknown', projectId: ''),
    );

    return InkWell(
      onTap: () => context.go('/task/${task.id}'),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(timer.description, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text('${project.name} - ${task.name}', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Text(
                _formatDuration(timer.duration),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (timer.status != TimerStatus.stopped)
                Row(
                  children: [
                    IconButton(
                      iconSize: 36,
                      icon: Icon(timer.status == TimerStatus.running ? Icons.pause_circle_filled : Icons.play_circle_filled, color: Theme.of(context).primaryColor),
                      onPressed: () {
                        if (timer.status == TimerStatus.running) {
                          bloc.add(PauseTimer(timer.id));
                        } else {
                          bloc.add(StartTimer(timer.id));
                        }
                      },
                    ),
                    IconButton(
                      iconSize: 36,
                      icon: const Icon(Icons.stop_circle_outlined, color: Colors.red),
                      onPressed: () {
                        bloc.add(StopTimer(timer.id));
                      },
                    ),
                  ],
                )
              else
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text('Completed', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }
}
