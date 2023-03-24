import 'dart:convert';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/keys.dart';
import 'package:todo/app/data/services/storage/services.dart';

import '../../models/tasks.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

  List<Task> readTask() {
    var tasks = <Task>[];
    List check = _storage.read(taskKey.toString());
    if (check.isNotEmpty) {
    List s = jsonDecode(_storage.read(taskKey.toString()));
      s.forEach((element) => tasks.add(Task.fromJson(element)));
    }
    return tasks;
  }

  void writeTask(List<Task> value) {
    _storage.write(taskKey, jsonEncode(value));
  }
}
