import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/models/progress_model.dart';
import 'package:flutter_task_manager_project/data/models/task_list_model.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:flutter_task_manager_project/ui/screen/add_new_task_screen.dart';
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
     //TaskListModel _taskListModel = TaskListModel();
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
              child:_getProgressTasksInProgress ? const Center(child: CupertinoActivityIndicator()) : ListView.separated(
            itemCount: _progressModel.data?.length ?? 0,
            itemBuilder: (context, index) {
              return  TaskListTile(
                title: _progressModel.data?[index].title ?? 'Unknown',
                description: _progressModel.data?[index].description ?? '',
                date: _progressModel.data?[index].createdDate ?? '',
                chipText: _progressModel.data?[index].status ?? '',
                color: Colors.blueAccent, 
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
      ),
      ),
        floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewTaskScreen()));
        },
      ),
    );
  }
}
