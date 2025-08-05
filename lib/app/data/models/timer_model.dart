import 'package:equatable/equatable.dart';

enum TimerStatus {
  paused,
  running,
  stopped,
}

class TimerModel extends Equatable {
  final String id;
  final String description;
  final String projectId;
  final String taskId;
  final bool isFavorite;
  final int duration;
  final TimerStatus status;
  final DateTime createdAt;

  const TimerModel({
    required this.id,
    required this.description,
    required this.projectId,
    required this.taskId,
    this.isFavorite = false,
    this.duration = 0,
    this.status = TimerStatus.paused,
    required this.createdAt,
  });

  TimerModel copyWith({
    String? id,
    String? description,
    String? projectId,
    String? taskId,
    bool? isFavorite,
    int? duration,
    TimerStatus? status,
    DateTime? createdAt,
  }) {
    return TimerModel(
      id: id ?? this.id,
      description: description ?? this.description,
      projectId: projectId ?? this.projectId,
      taskId: taskId ?? this.taskId,
      isFavorite: isFavorite ?? this.isFavorite,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory TimerModel.fromJson(Map<String, dynamic> json) {
    return TimerModel(
      id: json['id'],
      description: json['description'],
      projectId: json['projectId'],
      taskId: json['taskId'],
      isFavorite: json['isFavorite'] ?? false,
      duration: json['duration'] ?? 0,
      status: TimerStatus.values.firstWhere(
        (e) => e.toString() == 'TimerStatus.${json['status']}',
        orElse: () => TimerStatus.paused,
      ),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'projectId': projectId,
      'taskId': taskId,
      'isFavorite': isFavorite,
      'duration': duration,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        description,
        projectId,
        taskId,
        isFavorite,
        duration,
        status,
        createdAt,
      ];
}
