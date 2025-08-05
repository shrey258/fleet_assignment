import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fleet_assignment/app/widgets/app_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/data/models/project_model.dart';
import '../../../app/data/models/task_model.dart';
import '../../timers_list/bloc/timer_bloc.dart';
import '../../timers_list/widgets/timer_list_item.dart';

class TaskDetailsScreen extends StatefulWidget {
  final ProjectModel project;
  final TaskModel task;

  const TaskDetailsScreen({super.key, required this.project, required this.task});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> with SingleTickerProviderStateMixin {
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
        title: Text('${widget.project.name} - ${widget.task.name}'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Details'),
            Tab(text: 'Timesheets'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDetailsTab(),
          _buildTimesheetsTab(),
        ],
      ),
    ));
  }

  Widget _buildDetailsTab() {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Task: ${widget.task.name}', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16.h),
          Text('Project: ${widget.project.name}', style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: 16.h),
          Text('Deadline: 2024-12-31', style: Theme.of(context).textTheme.bodyLarge), // Static data
          SizedBox(height: 8.h),
          Text('Assigned to: John Doe', style: Theme.of(context).textTheme.bodyLarge), // Static data
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

        final taskTimers = state.timers.where((timer) => timer.taskId == widget.task.id).toList();

        if (taskTimers.isEmpty) {
          return const Center(child: Text('No timers for this task.'));
        }

        return ListView.builder(
          itemCount: taskTimers.length,
          itemBuilder: (context, index) {
            return TimerListItem(timer: taskTimers[index]);
          },
        );
      },
    );
  }
}
