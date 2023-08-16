import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/state_manager/status_task_controller.dart';
import 'package:get/get.dart';

import '../../data/utils/urls.dart';

class UpdateStatusTaskScreen extends StatefulWidget {
  final String taskId, taskStatus;
  final VoidCallback onUpdate;
  const UpdateStatusTaskScreen(
      {super.key,
      required this.taskId,
      required this.taskStatus,
      required this.onUpdate});

  @override
  State<UpdateStatusTaskScreen> createState() => _UpdateStatusTaskScreenState();
}

class _UpdateStatusTaskScreenState extends State<UpdateStatusTaskScreen> {

  final StatusTaskController _statusTaskController = Get.find<StatusTaskController>();

  List<String> taskStatusList = ['New', 'Progress', 'Cancel', 'Completed'];

  late String _selectedTask;

  @override
  void initState() {
    _selectedTask = widget.taskStatus.toLowerCase();
    super.initState();
  }

  // Future<void> updateTask({required String taskId,required String newStatus}) async {
  //   updateTaskProgress = true;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   final NetworkResponse response = await NetworkCaller().getRequest(Urls.updateTasks(taskId, newStatus));
  //   updateTaskProgress = false;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   if (response.isSuccess) {
  //     widget.onUpdate();
  //     if (mounted) {
  //       Navigator.pop(context);
  //     }
  //   } else {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Update of task has been failed')));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Update Task"),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: taskStatusList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      _selectedTask = taskStatusList[index];
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    title: Text(taskStatusList[index]),
                    trailing: _selectedTask == taskStatusList[index]
                        ? const Icon(Icons.check)
                        : null,
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GetBuilder<StatusTaskController>(
              builder: (_) {
                return _statusTaskController.updateTaskProgress
                    ? const Center(child: CupertinoActivityIndicator())
                    : ElevatedButton(
                        onPressed: () {
                          _statusTaskController.updateTask(taskId: widget.taskId, newStatus: _selectedTask, onUpdate: widget.onUpdate,);
                          //updateTask(widget.taskId, _selectedTask);
                        },
                        child: const Text("Update"));
              }
            ),
          )
        ],
      ),
    );
  }
}
