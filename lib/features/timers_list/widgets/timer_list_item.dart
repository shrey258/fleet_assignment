import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fleet_assignment/app/widgets/glass_container.dart';
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: GlassContainer(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        timer.description,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '${project.name} - ${task.name}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.w),
                if (timer.status != TimerStatus.stopped)
                  GestureDetector(
                    onTap: () {
                      if (timer.status == TimerStatus.running) {
                        bloc.add(PauseTimer(timer.id));
                      } else {
                        bloc.add(StartTimer(timer.id));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(64.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _formatDuration(timer.duration),
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: const Color(0xFF0C1D4D),
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Icon(
                            timer.status == TimerStatus.running
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 24.r,
                            color: const Color(0xFF0C1D4D),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Text(
                      'Completed',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDuration(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    if (duration.inHours >= 1) {
      final hours = twoDigits(duration.inHours);
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      return '$hours:$minutes';
    } else {
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return '$minutes:$seconds';
    }
  }
}
