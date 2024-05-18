import 'package:ddtechnology1/Task_Work/task_model.dart';
import 'package:ddtechnology1/notification_service.dart';

void scheduleTaskNotification(Task task) {
  final notificationService = NotificationService();
  notificationService.init();
  DateTime scheduledTime = task.deadline.subtract(Duration(minutes: 10));
  notificationService.scheduleNotification(
    'Task Reminder',
    'Your task "${task.title}" is due soon.',
    scheduledTime,
  );
}
