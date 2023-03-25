import 'dart:convert';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/keys.dart';
import 'package:todo/app/data/services/storage/services.dart';

import '../../models/tasks.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

  List<Task> readTask() {
    var tasks = <Task>[];
    try {
      List<dynamic> tempList = _storage.read(taskKey.toString());
      for (var element in tempList) {
        tasks.add(Task.fromJson(element));
      }
    } catch (e) {
      printInfo(info: e.toString());
    }
    return tasks;
  }

  void writeTask(List<Task> value) {
    _storage.write(taskKey, value);
  }
}
