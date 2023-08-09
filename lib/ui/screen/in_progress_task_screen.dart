

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/models/progress_model.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:flutter_task_manager_project/ui/screen/add_new_task_screen.dart';
import 'package:flutter_task_manager_project/ui/screen/update_status_task_screen.dart';
import 'package:flutter_task_manager_project/ui/widgets/screen_background.dart';
import 'package:flutter_task_manager_project/ui/widgets/task_list_tile.dart';
import 'package:flutter_task_manager_project/ui/widgets/user_profile_banner.dart';

class InProgressScreen extends StatefulWidget {
  const InProgressScreen({super.key});

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {
  ProgressModel _progressModel = ProgressModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getInProgressTasks();
    });
  }

  bool _getProgressTasksInProgress = false;

  Future<void> getInProgressTasks() async {
    _getProgressTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.progressTasks);
    
    

    if (response.isSuccess) {
      _progressModel = ProgressModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Progress data get failed')));
      }
    }
      _getProgressTasksInProgress = false;

     if (_progressModel.data == null || _progressModel.data!.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No data found')));
      }
    }
    
    if (mounted) {
      setState(() {});
    }
   
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteTasks(taskId));

    if (response.isSuccess) {
      _progressModel.data!.removeWhere((element) => element.sId == taskId);
      if (mounted) {
        setState(() {});
      }
      //  getNewTasks(); /// api call kore delete
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Deletion of task has been failed')));
      }
    }
  }

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
                getInProgressTasks();
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
                child: _getProgressTasksInProgress
                    ? const Center(child: CupertinoActivityIndicator(radius: 20,))
                    :_progressModel.data != null && _progressModel.data!.isEmpty
                    ? const Center(child: Text('No data found'))
                    : Padding(
                       padding: const EdgeInsets.only(top:16.0),
                      child: ListView.separated(
                          itemCount: _progressModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskListTile(
                              title:
                                  _progressModel.data?[index].title ?? 'Unknown',
                              description:
                                  _progressModel.data?[index].description ?? '',
                              date: _progressModel.data?[index].createdDate ?? '',
                              chipText: _progressModel.data?[index].status ?? '',
                              color: Colors.blueAccent,
                              onDeleteTab: () {
                                deleteTask(_progressModel.data![index].sId!);
                              },
                              onEditTab: () {
                                showStatusUpdateBottomSheet(
                                  taskId: _progressModel.data![index].sId!,
                                  taskStatus: _progressModel.data![index].status!,
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
                    ))
          ],
        ),
      ),
      
    );
  }
}
