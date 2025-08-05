import 'package:flutter/material.dart';
import 'package:fleet_assignment/app/widgets/app_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../bloc/timer_bloc.dart';
import '../widgets/timer_list_item.dart';

class TimersListScreen extends StatelessWidget {
  const TimersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Timesheets'),
          centerTitle: false,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                color: const Color(0x14FFFFFF),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: IconButton(
                padding: EdgeInsets.all(8.r),
                constraints: BoxConstraints(minWidth: 48.w, minHeight: 48.h),
                icon: const Icon(Icons.add),
                onPressed: () => context.go('/create'),
              ),
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
              return Center(
                child: Text('Failed to load timers: ${state.message}'),
              );
            }
            return const Center(child: Text('No timers found.'));
          },
        ),
      ),
    );
  }
}
