import 'package:flutter_task_manager_project/data/models/cancel_task_model.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:get/get.dart';

class CancelTaskController extends GetxController{
  CancelTaskModel _cancelTaskModel = CancelTaskModel();
  bool _isCancelTaskInProgress = false;

  bool get isCancelTaskInProgress => _isCancelTaskInProgress;
  CancelTaskModel get cancelTaskModel => _cancelTaskModel;

  Future<bool> getCancelTask() async {
    _isCancelTaskInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.cancelledTasks);

    _isCancelTaskInProgress = false;
    update();
    if (response.isSuccess) {
      _cancelTaskModel = CancelTaskModel.fromJson(response.body!);
      return true;
    } else {
      return  false;
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Cancelled data get failed')));
      // }
    }



    // if (_cancelTaskModel.data == null || _cancelTaskModel.data!.isEmpty) {
    //   if (mounted) {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(const SnackBar(content: Text('No data found')));
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
    cancelTaskModel.data!.removeWhere((element) => element.sId == taskId);
   update();
   return true;
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