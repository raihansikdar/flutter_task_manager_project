

import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/data/models/completed_task_model.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:flutter_task_manager_project/ui/widgets/screen_background.dart';
import 'package:flutter_task_manager_project/ui/widgets/task_list_tile.dart';
import 'package:flutter_task_manager_project/ui/widgets/user_profile_banner.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  CompletedTaskModel _completedTaskModel = CompletedTaskModel();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCompletedTasks();
    });
  }
  bool _getProgressTasksInProgress = false;

  Future<void> getCompletedTasks() async {
      _getProgressTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }


    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.completedTasks);

    if (response.isSuccess) {
      _completedTaskModel = CompletedTaskModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Progress data get failed')));
      }
    }
      _getProgressTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }

 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Column(
        children: [
           const UserProfileBanner(isUpdateScreen: false),
          Expanded(
              child:_getProgressTasksInProgress ? Center(child: CircularProgressIndicator()): ListView.separated(
            itemCount: _completedTaskModel.data?.length ?? 0,
            itemBuilder: (context, index) {
              return TaskListTile(
                title: _completedTaskModel.data?[index].title ?? '',
                description: _completedTaskModel.data?[index].description ?? '',
                date: _completedTaskModel.data?[index].createdDate ?? '',
                chipText: _completedTaskModel.data?[index].status ?? '',
                color: Colors.green,
                onDeleteTab: () {  }, 
                onEditTab: () {  },
              );
            },
            separatorBuilder: (context, index) => Divider(
              height: 10,
              thickness: 4,
              color: Colors.grey.shade200,
            ),
          ))
        ],
      )),
    );
  }
}
