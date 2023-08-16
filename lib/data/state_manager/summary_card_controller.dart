import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/models/summary_count_model.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:get/get.dart';

class SummaryCardController extends GetxController{
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  bool _getCountSummaryInProgress = false;

  bool get getCountSummaryInProgress => _getCountSummaryInProgress;
  SummaryCountModel get summaryCountModel => _summaryCountModel;

  Future<bool> getCountSummary() async {
    _getCountSummaryInProgress = true;
    update();

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.taskStatusCount);

    _getCountSummaryInProgress = false;
    update();

    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
      return true;
    } else {
      return false;

    }

  }
}