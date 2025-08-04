enum TimerStatus {
  paused,
  running,
  stopped,
}

class TimerModel {
  final String id;
  final String description;
  final String projectId;
  final String taskId;
  final bool isFavorite;
  final Duration duration;
  final TimerStatus status;

  TimerModel({
    required this.id,
    required this.description,
    required this.projectId,
    required this.taskId,
    this.isFavorite = false,
    this.duration = Duration.zero,
    this.status = TimerStatus.paused,
  });

  TimerModel copyWith({
    String? id,
    String? description,
    String? projectId,
    String? taskId,
    bool? isFavorite,
    Duration? duration,
    TimerStatus? status,
  }) {
    return TimerModel(
      id: id ?? this.id,
      description: description ?? this.description,
      projectId: projectId ?? this.projectId,
      taskId: taskId ?? this.taskId,
      isFavorite: isFavorite ?? this.isFavorite,
      duration: duration ?? this.duration,
      status: status ?? this.status,
    );
  }
}
