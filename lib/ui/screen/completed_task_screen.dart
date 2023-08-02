import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/ui/widgets/screen_background.dart';
import 'package:flutter_task_manager_project/ui/widgets/task_list_tile.dart';
import 'package:flutter_task_manager_project/ui/widgets/user_profile_banner.dart';

class CompleteTaskScreen extends StatelessWidget {
  const CompleteTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Column(
        children: [
           const UserProfileBanner(),
         
          Expanded(
              child: ListView.separated(
            itemCount: 20,
            itemBuilder: (context, index) {
              return  const TaskListTile(
                chipText: "Complete",
                color: Colors.green,
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