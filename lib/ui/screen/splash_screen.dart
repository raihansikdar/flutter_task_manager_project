import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_task_manager_project/data/models/auth_utility.dart';
import 'package:flutter_task_manager_project/ui/screen/auth/login_screen.dart';
import 'package:flutter_task_manager_project/ui/screen/bottom_nav_base_screen.dart';
import 'package:flutter_task_manager_project/ui/utils/assets_utils.dart';
import 'package:flutter_task_manager_project/ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToLogin();
    super.initState();
  }

  void navigateToLogin() async {
    // Future.delayed(const Duration(seconds: 3)).then((value) =>
    //     Navigator.pushAndRemoveUntil(
    //         context, MaterialPageRoute(builder: (context) =>const LoginScreen(),), (
    //         route) => false),
    // );

    await Future.delayed(const Duration(seconds: 3));
    final bool isLoggedIn = await AuthUtility.checkedUserLoggedin();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>isLoggedIn ? const BottomNavBaseScreen(): const LoginScreen(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SvgPicture.asset(
            AssetsUtils.logoSvg,
            width: 90,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
