import 'dart:convert';

import 'package:get/get.dart';
import 'package:task_manager/app/core/utils/keys.dart';
import 'package:task_manager/app/data/services/storage/models/task.dart';
import 'package:task_manager/app/data/services/storage/services.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

  // {'tasks':[
  //   {'title': 'work',
  //   'color': '#ff123456',
  //   'icon': 0xe123,
  //   }
  // ]}

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
