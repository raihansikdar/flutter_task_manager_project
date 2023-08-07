import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/ui/widgets/user_profile_banner.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            UserProfileBanner(isUpdateScreen: true)
          ],
        ),
      )),
    );
  }
}