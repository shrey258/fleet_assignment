part of 'timer_bloc.dart';

@immutable
abstract class TimerState extends Equatable {
  const TimerState();

  @override
  List<Object> get props => [];
}

class TimerInitial extends TimerState {}

class TimerLoadInProgress extends TimerState {}

class TimerLoadSuccess extends TimerState {
  final List<TimerModel> timers;
  final List<ProjectModel> projects;
  final List<TaskModel> tasks;

  const TimerLoadSuccess({
    required this.timers,
    required this.projects,
    required this.tasks,
  });

  @override
  List<Object> get props => [timers, projects, tasks];
}

class TimerLoadFailure extends TimerState {
  final String message;

  const TimerLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}
