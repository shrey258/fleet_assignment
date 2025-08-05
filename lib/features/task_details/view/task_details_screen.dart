import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fleet_assignment/app/widgets/app_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/data/models/project_model.dart';
import '../../../app/data/models/task_model.dart';
import '../../../app/data/models/timer_model.dart';
import '../../timers_list/bloc/timer_bloc.dart';

class TaskDetailsScreen extends StatefulWidget {
  final ProjectModel project;
  final TaskModel task;

  const TaskDetailsScreen({
    super.key,
    required this.project,
    required this.task,
  });

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.task.name),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // TODO: Navigate to edit task
              },
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Timesheets'),
              Tab(text: 'Details'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [_buildTimesheetsTab(), _buildDetailsTab()],
        ),
      ),
    );
  }

  Widget _buildDetailsTab() {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Section
          _buildDetailCard(
            title: 'Project',
            content: widget.project.name,
            hasAmberBar: true,
          ),
          SizedBox(height: 16.h),

          // Deadline Section
          _buildDetailCard(title: 'Deadline', content: '10/11/2023'),
          SizedBox(height: 16.h),

          // Assigned to Section
          _buildDetailCard(title: 'Assigned to', content: 'Ivan Zhuikov'),
          SizedBox(height: 16.h),

          // Description Section
          _buildDetailCard(
            title: 'Description',
            content:
                'As a user, I would like to be able to buy a subscription, this would allow me to get a discount on the products and on the second stage of diagnosis',
            isDescription: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard({
    required String title,
    required String content,
    bool hasAmberBar = false,
    bool isDescription = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          if (hasAmberBar)
            Container(
              width: 4.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          if (hasAmberBar) SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  content,
                  style: isDescription
                      ? Theme.of(context).textTheme.bodyMedium
                      : Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimesheetsTab() {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        if (state is! TimerLoadSuccess) {
          return const Center(child: CircularProgressIndicator());
        }

        final taskTimers = state.timers
            .where((timer) => timer.taskId == widget.task.id)
            .toList();
        final activeTimer = taskTimers
            .where((timer) => timer.status != TimerStatus.stopped)
            .firstOrNull;
        final completedTimers = taskTimers
            .where((timer) => timer.status == TimerStatus.stopped)
            .toList();

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current Date and Start Time
              if (activeTimer != null) ...[
                Text(
                  _formatDayName(activeTimer.createdAt),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                Text(
                  _formatDate(activeTimer.createdAt),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Start Time ${_formatTime(activeTimer.createdAt)}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
              SizedBox(height: 24.h),

              // Large Timer Display
              if (activeTimer != null) ...[
                Center(
                  child: Text(
                    _formatLargeTimer(activeTimer.duration),
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Timer Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<TimerBloc>().add(
                          StopTimer(activeTimer.id),
                        );
                      },
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.stop,
                          size: 30.r,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 24.w),
                    GestureDetector(
                      onTap: () {
                        if (activeTimer.status == TimerStatus.running) {
                          context.read<TimerBloc>().add(
                            PauseTimer(activeTimer.id),
                          );
                        } else {
                          context.read<TimerBloc>().add(
                            StartTimer(activeTimer.id),
                          );
                        }
                      },
                      child: Container(
                        width: 80.w,
                        height: 80.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          activeTimer.status == TimerStatus.running
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 40.r,
                          color: const Color(0xFF0C1D4D),
                        ),
                      ),
                    ),
                    SizedBox(width: 24.w),
                    Container(
                      width: 60.w,
                      height: 60.h,
                      // Placeholder for favorite button
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
              ] else ...[
                Center(
                  child: Text(
                    'No active timer',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: 32.h),
              ],

              // Description Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.edit,
                          size: 20.r,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      activeTimer?.description ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(height: 24.h),

              // Completed Records Section
              if (completedTimers.isNotEmpty) ...[
                Text(
                  'Completed Records',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                ...completedTimers.map((timer) => _buildCompletedRecord(timer)),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildCompletedRecord(timer) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, color: Colors.green, size: 20.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sunday',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '16.06.2023',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Start Time 10:00',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '08:00',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  String _formatLargeTimer(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  String _formatDayName(DateTime date) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[date.weekday - 1];
  }

  String _formatDate(DateTime date) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(date.day)}.${twoDigits(date.month)}.${date.year}';
  }

  String _formatTime(DateTime time) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(time.hour)}:${twoDigits(time.minute)}';
  }
}
