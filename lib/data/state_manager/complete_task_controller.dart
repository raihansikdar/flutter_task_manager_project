import 'package:flutter_task_manager_project/data/models/completed_task_model.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:get/get.dart';

class CompleteTaskController extends GetxController{
  CompletedTaskModel _completedTaskModel = CompletedTaskModel();
  bool _getCompleteTasksInProgress = false;

  bool get getCompleteTasksInProgress => _getCompleteTasksInProgress;
  CompletedTaskModel get completedTaskModel => _completedTaskModel;

  Future<bool> getCompletedTasks() async {
    _getCompleteTasksInProgress = true;
    update();

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.completedTasks);

    _getCompleteTasksInProgress = false;

    if (response.isSuccess) {
      _completedTaskModel = CompletedTaskModel.fromJson(response.body!);
      update();
      return true;
    } else {
      update();
      return false;
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Progress data get failed')));
      // }
    }

    // if (_completedTaskModel.data == null || _completedTaskModel.data!.isEmpty) {
    //   if (mounted) {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(const SnackBar(content: Text('No data found')));
    //   }
    // }
    // if (mounted) {
    //   setState(() {});
    // }
  }
  Future<bool> deleteTask(String taskId) async {
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.deleteTasks(taskId));

    if (response.isSuccess) {
      completedTaskModel.data!.removeWhere((element) => element.sId == taskId);
      update();
      return true;
      // if (mounted) {
      //   setState(() {});
      // }
      //  getNewTasks(); /// api call kore delete but eita valo method na
    } else {
      return false;
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Deletion of task has been failed')));
      // }
    }
  }
}