import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../app/data/models/project_model.dart';
import '../../../app/data/models/task_model.dart';
import '../../../app/data/models/timer_model.dart';
import '../../../app/data/repositories/timer_repository.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final TimerRepository _timerRepository;

  TimerBloc(this._timerRepository) : super(TimerInitial()) {
    on<LoadTimers>(_onLoadTimers);
    on<AddTimer>(_onAddTimer);
    on<UpdateTimer>(_onUpdateTimer);
    on<StartTimer>(_onStartTimer);
    on<PauseTimer>(_onPauseTimer);
    on<StopTimer>(_onStopTimer);
  }

  Future<void> _onLoadTimers(LoadTimers event, Emitter<TimerState> emit) async {
    emit(TimerLoadInProgress());
    try {
      final timers = await _timerRepository.getTimers();
      final projects = await _timerRepository.getProjects();
      final tasks = <TaskModel>[];
      for (var project in projects) {
        tasks.addAll(await _timerRepository.getTasksForProject(project.id));
      }
      emit(TimerLoadSuccess(timers: timers, projects: projects, tasks: tasks));
    } catch (e) {
      emit(TimerLoadFailure(e.toString()));
    }
  }

  Future<void> _onAddTimer(AddTimer event, Emitter<TimerState> emit) async {
    await _timerRepository.addTimer(event.timer);
    add(LoadTimers());
  }

  Future<void> _onUpdateTimer(UpdateTimer event, Emitter<TimerState> emit) async {
    await _timerRepository.updateTimer(event.timer);
    add(LoadTimers());
  }

  Future<void> _onStartTimer(StartTimer event, Emitter<TimerState> emit) async {
    final state = this.state;
    if (state is TimerLoadSuccess) {
      final timer = state.timers.firstWhere((t) => t.id == event.timerId);
      final updatedTimer = timer.copyWith(status: TimerStatus.running);
      await _timerRepository.updateTimer(updatedTimer);
      add(LoadTimers());
    }
  }

  Future<void> _onPauseTimer(PauseTimer event, Emitter<TimerState> emit) async {
    final state = this.state;
    if (state is TimerLoadSuccess) {
      final timer = state.timers.firstWhere((t) => t.id == event.timerId);
      final updatedTimer = timer.copyWith(status: TimerStatus.paused);
      await _timerRepository.updateTimer(updatedTimer);
      add(LoadTimers());
    }
  }

  Future<void> _onStopTimer(StopTimer event, Emitter<TimerState> emit) async {
    final state = this.state;
    if (state is TimerLoadSuccess) {
      final timer = state.timers.firstWhere((t) => t.id == event.timerId);
      final updatedTimer = timer.copyWith(status: TimerStatus.stopped);
      await _timerRepository.updateTimer(updatedTimer);
      add(LoadTimers());
    }
  }
}
