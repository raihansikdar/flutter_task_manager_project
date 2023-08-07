import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';

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
  List<String> taskStatusList = ['new', 'progress', 'cancel', 'completed'];

  late String _selectedTask;
  bool updateTaskProgress = false;
  @override
  void initState() {
    _selectedTask = widget.taskStatus.toLowerCase();
    super.initState();
  }

  Future<void> updateTask(String taskId, String newStatus) async {
    updateTaskProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.updateTasks(taskId, newStatus));
    updateTaskProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      widget.onUpdate();
      if (mounted) {
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Update of task has been failed')));
      }
    }
  }

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
            child: updateTaskProgress
                ? const Center(child: CupertinoActivityIndicator())
                : ElevatedButton(
                    onPressed: () {
                      updateTask(widget.taskId, _selectedTask);
                    },
                    child: const Text("Update")),
          )
        ],
      ),
    );
  }
}
