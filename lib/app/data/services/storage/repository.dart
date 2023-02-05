
import 'package:todo/app/data/models/tasks.dart';
import 'package:todo/app/data/providers/tasks/provider.dart';

class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});

  List<Task> readTask() => taskProvider.readTask();
  void writeTasks(List<Task> value) => taskProvider.writeTask(value);
} 