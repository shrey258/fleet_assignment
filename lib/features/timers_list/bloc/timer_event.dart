part of 'timer_bloc.dart';

@immutable
abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class LoadTimers extends TimerEvent {}

class AddTimer extends TimerEvent {
  final TimerModel timer;

  const AddTimer(this.timer);

  @override
  List<Object> get props => [timer];
}

class UpdateTimer extends TimerEvent {
  final TimerModel timer;

  const UpdateTimer(this.timer);

  @override
  List<Object> get props => [timer];
}

class StartTimer extends TimerEvent {
  final String timerId;

  const StartTimer(this.timerId);

  @override
  List<Object> get props => [timerId];
}

class PauseTimer extends TimerEvent {
  final String timerId;

  const PauseTimer(this.timerId);

  @override
  List<Object> get props => [timerId];
}

class StopTimer extends TimerEvent {
  final String timerId;

  const StopTimer(this.timerId);

  @override
  List<Object> get props => [timerId];
}

class _TimerTicked extends TimerEvent {
  final String timerId;

  const _TimerTicked(this.timerId);

  @override
  List<Object> get props => [timerId];
}
