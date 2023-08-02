import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/data/models/auth_utility.dart';
import 'package:flutter_task_manager_project/ui/screen/auth/login_screen.dart';

class UserProfileBanner extends StatelessWidget {
  const UserProfileBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.green,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        //  tileColor: Colors.green,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(AuthUtility.userInfo.data?.photo ?? ''),
          onBackgroundImageError: (exception, stackTrace) {
            const Icon(Icons.image);
          },
          radius: 15,
        ),
        title: Text(
          "${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}",
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
        subtitle: Text(
          AuthUtility.userInfo.data?.email ?? 'Unknown',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),

        trailing: IconButton(
            onPressed: () {
              AuthUtility.clearUserInfo();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            },
            icon: const Icon(Icons.logout)),
      ),
    );
  }
}
