import 'package:flutter_task_manager_project/data/models/auth_utility.dart';
import 'package:flutter_task_manager_project/data/models/login_model.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  bool _loginInProgress = false;
  bool get loginInProgress => _loginInProgress;

  Future<bool> login({required String email,required String password}) async {
    _loginInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };

    final NetworkResponse response = await NetworkCaller()
        .postRequest(Urls.login, requestBody, isLogin: true);

    _loginInProgress = false;
    update();

    if (response.isSuccess) {
      LoginModel model = LoginModel.fromJson(response.body!);
      await AuthUtility.saveUserInfo(model);

      // if (mounted) {
      //   Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => const BottomNavBaseScreen()),
      //           (route) => false);
      // }
      return true;
    } else {
      return false;
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Incorrect email or password')));
      // }
    }
  }
}