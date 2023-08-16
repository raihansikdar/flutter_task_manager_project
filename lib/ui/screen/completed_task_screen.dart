import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/data/models/completed_task_model.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/state_manager/complete_task_controller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:flutter_task_manager_project/ui/screen/update_status_task_screen.dart';
import 'package:flutter_task_manager_project/ui/widgets/screen_background.dart';
import 'package:flutter_task_manager_project/ui/widgets/task_list_tile.dart';
import 'package:flutter_task_manager_project/ui/widgets/user_profile_banner.dart';
import 'package:get/get.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {

  final CompleteTaskController _completeTaskController = Get.find<CompleteTaskController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _completeTaskController.getCompletedTasks();
    });
  }





  // Future<void> deleteTask(String taskId) async {
  //   final NetworkResponse response =
  //       await NetworkCaller().getRequest(Urls.deleteTasks(taskId));
  //
  //   if (response.isSuccess) {
  //     _completeTaskController.completedTaskModel.data!.removeWhere((element) => element.sId == taskId);
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
                _completeTaskController.getCompletedTasks();
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
              child: GetBuilder<CompleteTaskController>(

                builder: (_) {
                  return _completeTaskController.getCompleteTasksInProgress
                      ? const Center(child: CupertinoActivityIndicator(radius: 20,))
                      : _completeTaskController.completedTaskModel.data != null && _completeTaskController.completedTaskModel.data!.isEmpty
                          ? const Center(child: Text('No data found'))
                          : Padding(
                             padding: const EdgeInsets.only(top:16.0),
                            child: ListView.separated(
                                itemCount: _completeTaskController.completedTaskModel.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return TaskListTile(
                                    title:
                                    _completeTaskController.completedTaskModel.data?[index].title ?? '',
                                    description: _completeTaskController.completedTaskModel.data?[index].description ?? '',
                                    date: _completeTaskController.completedTaskModel.data?[index].createdDate ?? '',
                                    chipText:
                                    _completeTaskController.completedTaskModel.data?[index].status ?? '',
                                    color: Colors.green,
                                    onDeleteTab: () {
                                      _completeTaskController.deleteTask(_completeTaskController.completedTaskModel.data![index].sId!);
                                    },
                                    onEditTab: () {
                                       showStatusUpdateBottomSheet(
                                        taskId: _completeTaskController.completedTaskModel.data![index].sId!,
                                        taskStatus:_completeTaskController.completedTaskModel.data![index].status!,
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
