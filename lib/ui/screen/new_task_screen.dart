import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/models/summary_count_model.dart';
import 'package:flutter_task_manager_project/data/models/task_list_model.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/state_manager/new_task_controller.dart';
import 'package:flutter_task_manager_project/data/state_manager/summary_card_controller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:flutter_task_manager_project/ui/screen/add_new_task_screen.dart';
import 'package:flutter_task_manager_project/ui/screen/update_status_task_screen.dart';
import 'package:flutter_task_manager_project/ui/screen/update_task_screen.dart';
import 'package:flutter_task_manager_project/ui/widgets/sammary_card.dart';
import 'package:flutter_task_manager_project/ui/widgets/screen_background.dart';
import 'package:flutter_task_manager_project/ui/widgets/task_list_tile.dart';
import 'package:flutter_task_manager_project/ui/widgets/user_profile_banner.dart';
import 'package:get/get.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  // SummaryCountModel _summaryCountModel = SummaryCountModel();
 // TaskListModel _taskListModel = TaskListModel();


  final SummaryCardController _summaryCardController = Get.find<SummaryCardController>();
  final NewTaskController _newTaskController = Get.find<NewTaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _summaryCardController.getCountSummary();
      _newTaskController.getNewTasks();
    });
  }



  // Future<void> deleteTask({required String taskId}) async {
  //   final NetworkResponse response =
  //       await NetworkCaller().getRequest(Urls.deleteTasks(taskId));
  //
  //   if (response.isSuccess) {
  //     _newTaskController.taskListModel.data!.removeWhere((element) => element.sId == taskId);
  //     if (mounted) {
  //       setState(() {});
  //     }
  //     //  getNewTasks(); /// api call kore delete
  //   } else {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Deletion of task has been failed')));
  //     }
  //   }
  // }

  void showEditBottomSheet(
      {required String taskId,
      required String currentTitle,
      required String currentDescription}) {
    final TextEditingController _titleController =
        TextEditingController(text: currentTitle);
    final TextEditingController _descriptionController =
        TextEditingController(text: currentDescription);
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return UpdateTaskSheet(
            titleController: _titleController,
            descriptionController: _descriptionController,
            onUpdate: () {
              _newTaskController.getNewTasks();
            },
          );
        });
  }

  void showStatusUpdateBottomSheet({required String taskId, required String taskStatus}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return UpdateStatusTaskScreen(
              taskId: taskId,
              taskStatus: taskStatus,
              onUpdate: () {
                _newTaskController.getNewTasks();
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: RefreshIndicator(
          onRefresh: () async {
            _newTaskController.getNewTasks();
            _summaryCardController.getCountSummary();
          },
          child: GetBuilder<NewTaskController>(
            builder: (_) {
              return _newTaskController.getNewTaskInProgress
                  ? const Center(
                      child: SizedBox(
                        height: 320,
                        width: 220,
                        child: AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CupertinoActivityIndicator(
                                radius: 20,
                                color: Colors.black,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Loading....',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        const UserProfileBanner(isUpdateScreen: false),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 80,
                              width: double.infinity,
                              child:
                                  GetBuilder<SummaryCardController>(builder: (_) {

                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _summaryCardController.summaryCountModel.data?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return SummaryCard(
                                        number: _summaryCardController.summaryCountModel.data?[index].sum ?? 0,
                                        title: _summaryCardController.summaryCountModel.data?[index].sId ?? "New",
                                      );
                                    });
                              }),
                            )),
                        Expanded(
                            child: GetBuilder<NewTaskController>(
                              builder: (_) {
                                return ListView.separated(
                              itemCount: _newTaskController.taskListModel.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                return TaskListTile(
                                  title: _newTaskController.taskListModel.data?[index].title ?? 'Unknown',
                                  description: _newTaskController.taskListModel.data?[index].description ?? '',
                                  date: _newTaskController.taskListModel.data?[index].createdDate ?? '',
                                  chipText: _newTaskController.taskListModel.data?[index].status ?? 'New',
                                  color: Colors.blue,

                                  onDeleteTab: () {
                                    _newTaskController.deleteTask(taskId:_newTaskController.taskListModel.data![index].sId!);
                                  },

                                  onEditTab: () {
                                    showStatusUpdateBottomSheet(
                                      taskId: _newTaskController.taskListModel.data![index].sId!,
                                      taskStatus: _newTaskController.taskListModel.data![index].status!,
                                    );
                                    // showEditBottomSheet(
                                    //   taskId: _taskListModel.data![index].sId!,
                                    //   currentTitle:
                                    //       _taskListModel.data![index].title!,
                                    //   currentDescription:
                                    //       _taskListModel.data![index].description!,
                                    // );
                                  },
                                );
                          },
                          separatorBuilder: (context, index) => Divider(
                                height: 10,
                                thickness: 4,
                                color: Colors.grey.shade200,
                          ),
                        );
                              }
                            )),
                      ],
                    );
            }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(()=> const AddNewTaskScreen(),transition: Transition.rightToLeft);
        },
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_task_manager_project/data/models/network_response.dart';
// import 'package:flutter_task_manager_project/data/models/summary_count_model.dart';
// import 'package:flutter_task_manager_project/data/models/task_list_model.dart';
// import 'package:flutter_task_manager_project/data/service/network_caller.dart';
// import 'package:flutter_task_manager_project/data/utils/urls.dart';
// import 'package:flutter_task_manager_project/ui/screen/add_new_task_screen.dart';
// import 'package:flutter_task_manager_project/ui/widgets/sammary_card.dart';
// import 'package:flutter_task_manager_project/ui/widgets/screen_background.dart';
// import 'package:flutter_task_manager_project/ui/widgets/task_list_tile.dart';
// import 'package:flutter_task_manager_project/ui/widgets/user_profile_banner.dart';

// class NewTaskScreen extends StatefulWidget {
//   const NewTaskScreen({super.key});

//   @override
//   State<NewTaskScreen> createState() => _NewTaskScreenState();
// }

// class _NewTaskScreenState extends State<NewTaskScreen> {
//   SummaryCountModel _summaryCountModel = SummaryCountModel();
//   TaskListModel _taskListModel = TaskListModel();

//   bool _getCountSummaryInProgress = false, _getNewTaskInProgress = false;
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       getCountSummary();
//       getNewTasks();
//     });
//   }

//   Future<void> getCountSummary() async {
//     _getCountSummaryInProgress = true;
//     if (mounted) {
//       setState(() {});
//     }
//     final NetworkResponse response =
//         await NetworkCaller().getRequest(Urls.taskStatusCount);

//     if (response.isSuccess) {
//       _summaryCountModel = SummaryCountModel.fromJson(response.body!);
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Summary data get Success')));
//       }
//     } else {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Summary data get failed')));
//       }
//     }

//     _getCountSummaryInProgress = false;
//     if (mounted) {
//       setState(() {});
//     }
//   }

//   Future<void> getNewTasks() async {
//     _getNewTaskInProgress = true;
//     if (mounted) {
//       setState(() {});
//     }
//     final NetworkResponse response =
//         await NetworkCaller().getRequest(Urls.newTasks);

//     if (response.isSuccess) {
//       _taskListModel = TaskListModel.fromJson(response.body!);
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('get new task data Success')));
//       }
//     } else {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('get new task data failed')));
//       }
//     }

//     _getNewTaskInProgress = false;
//     if (mounted) {
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ScreenBackground(
//         child: Column(
//           children: [
//             const UserProfileBanner(),
//             _getCountSummaryInProgress
//                 ? const LinearProgressIndicator()
//                 : const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                             child: SummaryCard(
//                           number: 120,
//                           title: "New",
//                         )),
//                         Expanded(
//                             child: SummaryCard(
//                           number: 120,
//                           title: "Progress",
//                         )),
//                         Expanded(
//                             child: SummaryCard(
//                           number: 120,
//                           title: "Canclelled",
//                         )),
//                         Expanded(
//                             child: SummaryCard(
//                           number: 120,
//                           title: "Complete",
//                         )),
//                       ],
//                     ),
//                   ),
//             Expanded(
//                 child: RefreshIndicator(
//                   onRefresh: ()async {
//                        getNewTasks();
//                    },
//                   child:_getNewTaskInProgress ? const Center(child:  CupertinoActivityIndicator(radius: 20,color: Colors.black,)) : ListView.separated(
//                               itemCount: _taskListModel.data?.length ?? 0,
//                               itemBuilder: (context, index) {
//                   return TaskListTile(
//                     data: _taskListModel.data![index],
//                     // chipText: "New",
//                     color: Colors.blue,
//                   );
//                               },
//                               separatorBuilder: (context, index) => Divider(
//                   height: 10,
//                   thickness: 4,
//                   color: Colors.grey.shade200,
//                               ),
//                             ),
//                 )),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const AddNewTaskScreen()));
//         },
//       ),
//     );
//   }
// }
