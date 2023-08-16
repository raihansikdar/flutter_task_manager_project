import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/data/models/cancel_task_model.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/state_manager/cancel_task_controller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:flutter_task_manager_project/ui/screen/update_status_task_screen.dart';
import 'package:flutter_task_manager_project/ui/widgets/screen_background.dart';
import 'package:flutter_task_manager_project/ui/widgets/task_list_tile.dart';
import 'package:flutter_task_manager_project/ui/widgets/user_profile_banner.dart';
import 'package:get/get.dart';

class CancellTaskScreen extends StatefulWidget {
  const CancellTaskScreen({super.key});

  @override
  State<CancellTaskScreen> createState() => _CancellTaskScreenState();
}

class _CancellTaskScreenState extends State<CancellTaskScreen> {
  final CancelTaskController _cancelTaskController = Get.find<CancelTaskController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _cancelTaskController.getCancelTask();
    });
  }





  // Future<void> deleteTask(String taskId) async {
  //   final NetworkResponse response =
  //       await NetworkCaller().getRequest(Urls.deleteTasks(taskId));
  //
  //   if (response.isSuccess) {
  //     _cancelTaskController.cancelTaskModel.data!.removeWhere((element) => element.sId == taskId);
  //     if (mounted) {
  //       setState(() {});
  //     }
  //     //  getNewTasks(); /// api call kore delete but eita valo method na
  //   } else {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Deletion of task has been failed')));
  //     }
  //   }
  // }

  void showStatusUpdateBottomSheet(
      {required String taskId, required String taskStatus}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return UpdateStatusTaskScreen(
              taskId: taskId,
              taskStatus: taskStatus,
              onUpdate: () {
                _cancelTaskController.getCancelTask();
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Column(
                children: [
          const UserProfileBanner(isUpdateScreen: false),
          Expanded(
              child: GetBuilder<CancelTaskController>(
                builder: (_) {
                  return _cancelTaskController.isCancelTaskInProgress
                      ? const Center(child: CupertinoActivityIndicator(radius: 20,))
                      : _cancelTaskController.cancelTaskModel.data != null && _cancelTaskController.cancelTaskModel.data!.isEmpty
                          ? const Center(child: Text('No data found'))
                          : Padding(
                            padding: const EdgeInsets.only(top:16.0),
                            child: ListView.separated(
                                itemCount: _cancelTaskController.cancelTaskModel.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return TaskListTile(
                                    title: _cancelTaskController.cancelTaskModel.data?[index].title ?? 'Unknown',
                                    description: _cancelTaskController.cancelTaskModel.data?[index].description ?? '',
                                    date: _cancelTaskController.cancelTaskModel.data?[index].createdDate ?? '',
                                    chipText: _cancelTaskController.cancelTaskModel.data?[index].status ?? '',
                                    color: Colors.red,
                                    onDeleteTab: () {
                                      _cancelTaskController.deleteTask(_cancelTaskController.cancelTaskModel.data![index].sId!);
                                    },
                                    onEditTab: () {
                                      showStatusUpdateBottomSheet(
                                        taskId: _cancelTaskController.cancelTaskModel.data![index].sId!,
                                        taskStatus:_cancelTaskController.cancelTaskModel.data![index].status!,
                                      );
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) => Divider(
                                  height: 10,
                                  thickness: 4,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                          );
                }
              ))
                ],
              )),
    );
  }
}
