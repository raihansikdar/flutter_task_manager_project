import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/models/task_list_model.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:get/get.dart';

class NewTaskController extends GetxController{
  TaskListModel _taskListModel = TaskListModel();
  bool _getNewTaskInProgress = false;

  bool get getNewTaskInProgress => _getNewTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getNewTasks() async {
    _getNewTaskInProgress = true;
    update();

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.newTasks);

    _getNewTaskInProgress = false;

    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
      update();
      return true;
    } else {
      update();
        return false;
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('get new task data failed')));
      // }
    }
  }

  Future<bool> deleteTask({required String taskId}) async {
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.deleteTasks(taskId));

    if (response.isSuccess) {
      taskListModel.data!.removeWhere((element) => element.sId == taskId);
      update();
      return true;
      //  getNewTasks(); /// api call kore delete
    } else {
      return false;
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Deletion of task has been failed')));
    }
  }
}