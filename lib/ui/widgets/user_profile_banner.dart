import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/data/models/auth_utility.dart';
import 'package:flutter_task_manager_project/ui/screen/auth/login_screen.dart';
import 'package:flutter_task_manager_project/ui/screen/update_profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserProfileBanner extends StatefulWidget {
  final bool? isUpdateScreen;
  const UserProfileBanner({
    super.key,
    required this.isUpdateScreen,
  });

  @override
  State<UserProfileBanner> createState() => _UserProfileBannerState();
}

class _UserProfileBannerState extends State<UserProfileBanner> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.green,
        title: GestureDetector(
          onTap: () {
            if ((widget.isUpdateScreen ?? false) == false) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const UpdateProfileScreen())));
            }
          },
          child: Row(
            children: [
              Visibility(
                visible: (widget.isUpdateScreen ?? false) == false,
                child: Row(
                  children: [
                    CachedNetworkImage(
                      placeholder: (_, __) => const Icon(Icons.account_circle_outlined),
                      imageUrl: AuthUtility.userInfo.data?.photo ?? '',
                      errorWidget: (_, __, ___) => const Icon(Icons.account_circle_outlined),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}",
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Text(
                    AuthUtility.userInfo.data?.email ?? 'Unknown',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                AuthUtility.clearUserInfo();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout)),
        ]);
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_task_manager_project/data/models/auth_utility.dart';
// import 'package:flutter_task_manager_project/ui/screen/auth/login_screen.dart';
// import 'package:flutter_task_manager_project/ui/screen/update_profile_screen.dart';

// class UserProfileBanner extends StatefulWidget {
//   final bool? isUpdateScreen;
//   const UserProfileBanner({
//     super.key, required this.isUpdateScreen,
//   });

//   @override
//   State<UserProfileBanner> createState() => _UserProfileBannerState();
// }

// class _UserProfileBannerState extends State<UserProfileBanner> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.green,
//       ),
//       child: ListTile(
//         onTap: () {
//           if((widget.isUpdateScreen ?? false)== false){
//                 Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: ((context) => const UpdateProfileScreen())));
//           }
         
//         },
//         contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
//         //  tileColor: Colors.green,
//         leading: CircleAvatar(
//           backgroundImage: NetworkImage(AuthUtility.userInfo.data?.photo ?? ''),
//           onBackgroundImageError: (exception, stackTrace) {
//             const Icon(Icons.image);
//           },
//           radius: 15,
//         ),
//         title: Text(
//           "${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}",
//           style: const TextStyle(fontSize: 14, color: Colors.white),
//         ),
//         subtitle: Text(
//           AuthUtility.userInfo.data?.email ?? 'Unknown',
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 12,
//           ),
//         ),

//         trailing: IconButton(
//             onPressed: () {
//               AuthUtility.clearUserInfo();
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginScreen()),
//                   (route) => false);
//             },
//             icon: const Icon(Icons.logout)),
//       ),
//     );
//   }
// }
