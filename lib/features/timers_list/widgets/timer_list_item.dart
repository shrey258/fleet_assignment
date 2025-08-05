import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/data/models/project_model.dart';
import '../../../app/data/models/task_model.dart';
import '../../../app/data/models/timer_model.dart';
import '../bloc/timer_bloc.dart';

class TimerListItem extends StatelessWidget {
  final TimerModel timer;

  const TimerListItem({super.key, required this.timer});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TimerBloc>();
    final state = bloc.state;

    String projectName = 'Unknown';
    String taskName = 'Unknown';

    if (state is TimerLoadSuccess) {
      final project = state.projects.firstWhere((p) => p.id == timer.projectId, orElse: () => ProjectModel(id: '', name: 'Unknown'));
      final task = state.tasks.firstWhere((t) => t.id == timer.taskId, orElse: () => TaskModel(id: '', name: 'Unknown', projectId: ''));
      projectName = project.name;
      taskName = task.name;
    }

    return Card(
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
                  Text('$projectName - $taskName', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Text(
              _formatDuration(timer.duration),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
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
          ],
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
