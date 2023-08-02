import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/ui/screen/cancelled_task_screen.dart';
import 'package:flutter_task_manager_project/ui/screen/completed_task_screen.dart';
import 'package:flutter_task_manager_project/ui/screen/in_progress_task_screen.dart';
import 'package:flutter_task_manager_project/ui/screen/new_task_screen.dart';

class BottomNavBaseScreen extends StatefulWidget {
  const BottomNavBaseScreen({super.key});

  @override
  State<BottomNavBaseScreen> createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {
  int _selectedScreenIndex = 0;
  final List<Widget> _screen = const [
    NewTaskScreen(),
    InProgressScreen(),
    CancellTaskScreen(),
    CompleteTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
         selectedItemColor: Colors.green,
        showUnselectedLabels: true,
        //backgroundColor: Colors.green,
        
        currentIndex: _selectedScreenIndex,
        onTap: (index) {
          _selectedScreenIndex = index;
            //print(_selectedScreenIndex);
          if(mounted){
            setState(() {});
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'New'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_tree), label: 'In Progress'),
          BottomNavigationBarItem(
              icon: Icon(Icons.cancel_outlined), label: 'Cancel'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_all), label: 'Completed'),
        ],
      ),
    );
  }
}
