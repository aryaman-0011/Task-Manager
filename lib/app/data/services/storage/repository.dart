// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:task_manager/app/data/providers/task/provider.dart';
import 'package:task_manager/app/data/services/storage/models/task.dart';

class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({
    required this.taskProvider,
  });

  List<Task> readTasks() => taskProvider.readTasks();
  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
