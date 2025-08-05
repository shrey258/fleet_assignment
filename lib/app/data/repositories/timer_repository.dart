import '../models/project_model.dart';
import '../models/task_model.dart';
import '../models/timer_model.dart';

class TimerRepository {
  final List<ProjectModel> _projects = [
    ProjectModel(id: '1', name: 'Odoo'),
    ProjectModel(id: '2', name: 'Fleet'),
  ];

  final List<TaskModel> _tasks = [
    TaskModel(id: '101', name: 'Task 1', projectId: '1'),
    TaskModel(id: '102', name: 'Task 2', projectId: '1'),
    TaskModel(id: '201', name: 'Task A', projectId: '2'),
    TaskModel(id: '202', name: 'Task B', projectId: '2'),
  ];

  final List<TimerModel> _timers = [
    TimerModel(
      id: '1',
      description: 'Working on UI implementation for the new feature.',
      projectId: '1',
      taskId: '101',
      isFavorite: true,
      duration: 5100,
      createdAt: DateTime.now(),
      status: TimerStatus.paused,
    ),
    TimerModel(
      id: '2',
      description: 'Fixing bugs reported by QA team.',
      projectId: '2',
      taskId: '201',
      duration: 2700,
      createdAt: DateTime.now(),
      status: TimerStatus.running,
    ),
  ];

  Future<List<ProjectModel>> getProjects() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _projects;
  }

  Future<List<TaskModel>> getTasksForProject(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _tasks.where((task) => task.projectId == projectId).toList();
  }

  Future<List<TaskModel>> getTasks() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _tasks;
  }

  Future<List<TimerModel>> getTimers() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _timers;
  }

  Future<void> addTimer(TimerModel timer) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _timers.add(timer);
  }

  Future<void> updateTimer(TimerModel timer) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _timers.indexWhere((t) => t.id == timer.id);
    if (index != -1) {
      _timers[index] = timer;
    }
  }
}
