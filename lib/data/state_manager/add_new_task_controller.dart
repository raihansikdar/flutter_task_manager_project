import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:get/get.dart';

class AddNewTaskController extends GetxController{
  bool _addNewTaskInProgress = false;

  bool get addNewTaskInProgress => _addNewTaskInProgress;

  Future<bool> addNewTask({required String title, required String description}) async {
    _addNewTaskInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New"
    };

    final NetworkResponse response = await NetworkCaller().postRequest(Urls.createTask, requestBody);

    _addNewTaskInProgress = false;
    update();

    if (response.isSuccess) {
        return true;
    } else {
      return false;
    }
  }

}