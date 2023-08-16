import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/models/progress_model.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:get/get.dart';

class ProgressTaskController extends GetxController{
  ProgressModel _progressModel = ProgressModel();
  bool _getProgressTasksInProgress = false;

  bool get getProgressTasksInProgress => _getProgressTasksInProgress;
  ProgressModel get progressModel => _progressModel;


  Future<bool> getInProgressTasks() async {
    _getProgressTasksInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.progressTasks);
    _getProgressTasksInProgress = false;
    update();

    if (response.isSuccess) {
      _progressModel = ProgressModel.fromJson(response.body!);

      return true;
    } else {
      return false;
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Progress data get failed')));
      // }
    }


    // if (_progressModel.data == null || _progressModel.data!.isEmpty) {
    //   if (mounted) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(content: Text('No data found')));
    //   }
    // }
    //
    // if (mounted) {
    //   setState(() {});
    // }

  }

  Future<bool> deleteTask(String taskId) async {
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.deleteTasks(taskId));

    if (response.isSuccess) {
        progressModel.data!.removeWhere((element) => element.sId == taskId);
        update();
        return true;
      // if (mounted) {
      //   setState(() {});
      // }
      //  getNewTasks(); /// api call kore delete
    } else {
      return false;
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Deletion of task has been failed')));
      // }
    }
  }
}