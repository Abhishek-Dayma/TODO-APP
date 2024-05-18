class Task {
  String id;
  String title;
  String description;
  DateTime deadline;
  Duration expectedDuration;
  bool isComplete;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.expectedDuration,
    required this.isComplete,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'deadline': deadline.toIso8601String(),
      'expectedDuration': expectedDuration.inMinutes,
      'isComplete': isComplete,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map, String id) {
    return Task(
      id: id,
      title: map['title'],
      description: map['description'],
      deadline: DateTime.parse(map['deadline']),
      expectedDuration: Duration(minutes: map['expectedDuration']),
      isComplete: map['isComplete'],
    );
  }
}
