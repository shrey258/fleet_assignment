import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../app/data/models/project_model.dart';
import '../../../app/data/models/task_model.dart';
import '../../../app/data/models/timer_model.dart';
import '../../../app/data/repositories/timer_repository.dart';
import '../../../app/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final TimerRepository _timerRepository;
  final Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;

  TimerBloc(this._timerRepository, this._ticker) : super(TimerInitial()) {
    on<LoadTimers>(_onLoadTimers);
    on<AddTimer>(_onAddTimer);
    on<UpdateTimer>(_onUpdateTimer);
    on<StartTimer>(_onStartTimer);
    on<PauseTimer>(_onPauseTimer);
    on<StopTimer>(_onStopTimer);
    on<_TimerTicked>(_onTimerTicked);
    
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Future<void> _onLoadTimers(LoadTimers event, Emitter<TimerState> emit) async {
    emit(TimerLoadInProgress());
    try {
      final timers = await _timerRepository.getTimers();
      final projects = await _timerRepository.getProjects();
      final tasks = await _timerRepository.getTasks();
      emit(TimerLoadSuccess(timers: timers, projects: projects, tasks: tasks));
    } catch (_) {
      emit(const TimerLoadFailure('Failed to load timers.'));
    }
  }

  void _onAddTimer(AddTimer event, Emitter<TimerState> emit) {
    final state = this.state;
    if (state is TimerLoadSuccess) {
      final List<TimerModel> updatedTimers = List.from(state.timers)..add(event.timer);
      emit(TimerLoadSuccess(timers: updatedTimers, projects: state.projects, tasks: state.tasks));
    }
  }

  void _onUpdateTimer(UpdateTimer event, Emitter<TimerState> emit) {
    final state = this.state;
    if (state is TimerLoadSuccess) {
      final List<TimerModel> updatedTimers = state.timers.map((timer) {
        return timer.id == event.timer.id ? event.timer : timer;
      }).toList();
      emit(TimerLoadSuccess(timers: updatedTimers, projects: state.projects, tasks: state.tasks));
    }
  }

  void _onStartTimer(StartTimer event, Emitter<TimerState> emit) {
    final state = this.state;
    if (state is TimerLoadSuccess) {
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker.tick().listen((_) => add(_TimerTicked(event.timerId)));

      final timers = state.timers.map((timer) {
        if (timer.id == event.timerId) {
          return timer.copyWith(status: TimerStatus.running);
        }
        return timer;
      }).toList();
      emit(TimerLoadSuccess(timers: timers, projects: state.projects, tasks: state.tasks));
    }
  }

  void _onPauseTimer(PauseTimer event, Emitter<TimerState> emit) {
    final state = this.state;
    if (state is TimerLoadSuccess) {
      _tickerSubscription?.pause();
      final timers = state.timers.map((timer) {
        if (timer.id == event.timerId) {
          return timer.copyWith(status: TimerStatus.paused);
        }
        return timer;
      }).toList();
      emit(TimerLoadSuccess(timers: timers, projects: state.projects, tasks: state.tasks));
    }
  }

  void _onStopTimer(StopTimer event, Emitter<TimerState> emit) {
    final state = this.state;
    if (state is TimerLoadSuccess) {
      _tickerSubscription?.cancel();
      final timers = state.timers.map((timer) {
        if (timer.id == event.timerId) {
          return timer.copyWith(status: TimerStatus.stopped);
        }
        return timer;
      }).toList();
      emit(TimerLoadSuccess(timers: timers, projects: state.projects, tasks: state.tasks));
    }
  }

  void _onTimerTicked(_TimerTicked event, Emitter<TimerState> emit) {
    final state = this.state;
    if (state is TimerLoadSuccess) {
      final updatedTimers = state.timers.map((timer) {
        if (timer.id == event.timerId) {
          return timer.copyWith(duration: timer.duration + 1);
        }
        return timer;
      }).toList();
      emit(TimerLoadSuccess(
        timers: updatedTimers,
        projects: state.projects,
        tasks: state.tasks,
      ));
    }
  }
}
