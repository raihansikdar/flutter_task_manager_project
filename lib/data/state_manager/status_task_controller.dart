

import 'dart:ui';

import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:get/get.dart';

class StatusTaskController extends GetxController{
  bool _updateTaskProgress = false;
  bool get updateTaskProgress => _updateTaskProgress;

  Future<bool> updateTask({required String taskId,required String newStatus, required VoidCallback onUpdate,}) async {
    _updateTaskProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.updateTasks(taskId, newStatus));
    _updateTaskProgress = false;
    update();

    if (response.isSuccess) {
       onUpdate();
      Get.back();
      return true;
      // if (mounted) {
      //   Navigator.pop(context);
      // }
    } else {
      return false;
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Update of task has been failed')));
      // }
    }
  }
}