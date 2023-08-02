import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/ui/screen/add_new_task_screen.dart';
import 'package:flutter_task_manager_project/ui/widgets/sammary_card.dart';
import 'package:flutter_task_manager_project/ui/widgets/screen_background.dart';
import 'package:flutter_task_manager_project/ui/widgets/task_list_tile.dart';
import 'package:flutter_task_manager_project/ui/widgets/user_profile_banner.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Column(
        children: [
           const UserProfileBanner(),
         const Padding(
            padding:  EdgeInsets.all(8.0),
            child:  Row(
              children: [
                Expanded(
                    child: SummaryCard(
                  number: 120,
                  title: "New",
                )),
                Expanded(
                    child: SummaryCard(
                  number: 120,
                  title: "Progress",
                )),
                Expanded(
                    child: SummaryCard(
                  number: 120,
                  title: "Canclelled",
                )),
                Expanded(
                    child: SummaryCard(
                  number: 120,
                  title: "Complete",
                )),
              ],
            ),
          ),
          Expanded(
              child: ListView.separated(
            itemCount: 20,
            itemBuilder: (context, index) {
              return  const TaskListTile(
                chipText: "New",
                color: Colors.blue,
              );
            },
            separatorBuilder: (context, index) => Divider(
              height: 10,
              thickness: 4,
              color: Colors.grey.shade200,
            ),
          )),
          
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

