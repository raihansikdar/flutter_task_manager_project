import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/data/models/cancel_task_model.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:flutter_task_manager_project/ui/widgets/screen_background.dart';
import 'package:flutter_task_manager_project/ui/widgets/task_list_tile.dart';
import 'package:flutter_task_manager_project/ui/widgets/user_profile_banner.dart';

class CancellTaskScreen extends StatefulWidget {
  const CancellTaskScreen({super.key});

  @override
  State<CancellTaskScreen> createState() => _CancellTaskScreenState();
}

class _CancellTaskScreenState extends State<CancellTaskScreen> {
  CancelTaskModel _cancelTaskModel = CancelTaskModel();
    @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCancelTask();
    });
  }


  bool isCancelTask = false;

  Future<void> getCancelTask() async {
    isCancelTask == true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.cancelledTasks);

    if (response.isSuccess) {
      _cancelTaskModel = CancelTaskModel.fromJson(response.body!);
    }else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cancelled data get failed')));
      }
    }

    isCancelTask == false;
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
          const UserProfileBanner(),
          Expanded(
              child: ListView.separated(
            itemCount: _cancelTaskModel.data?.length ?? 0,
            itemBuilder: (context, index) {
            
              return  TaskListTile(
                title:_cancelTaskModel.data?[index].title?? 'Unknown',
                description: _cancelTaskModel.data?[index].description ?? '',
                date: _cancelTaskModel.data?[index].createdDate ?? '',
                chipText: _cancelTaskModel.data?[index].status?? '',
                color: Colors.red,
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
