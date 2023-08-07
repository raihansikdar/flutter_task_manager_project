import 'package:flutter/material.dart';
//import 'package:flutter_task_manager_project/data/models/task_list_model.dart';

class TaskListTile extends StatelessWidget {
  final Color color;
  final String chipText;
  final String title;
  final String description;
  final String date;
  final VoidCallback onDeleteTab, onEditTab;
  // final TaskData data;
  const TaskListTile({
    super.key,
    required this.color,
    required this.chipText,
    required this.title,
    required this.description,
    required this.date, 
    required this.onDeleteTab, 
    required this.onEditTab,
    // required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description),
          Text(date),
          Row(
            children: [
              Chip(
                label: Text(
                  chipText,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: color,
              ),
              const Spacer(),
              IconButton(
                  onPressed: onEditTab,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.green,
                  )),
              IconButton(
                  onPressed: onDeleteTab,
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red.shade300,
                  )),
            ],
          )
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_task_manager_project/data/models/task_list_model.dart';

// class TaskListTile extends StatelessWidget {
//   final Color color;
//  // final String chipText;
//     final TaskData data;
//   const TaskListTile({
//     super.key,
//     required this.color,
//    // required this.chipText,
//     required this.data,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title:  Text(data.title ?? "Unkwon"),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//            Text(data.description ?? ''),
//            Text(data.createdDate ?? ''),
//           Row(
//             children: [
//               Chip(
//                 label: Text(
//                   data.status ?? 'New',
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 backgroundColor: color,
//               ),
//               const Spacer(),
//               IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.edit,
//                     color: Colors.green,
//                   )),
//               IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.delete_forever_outlined,
//                     color: Colors.red.shade300,
//                   )),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
