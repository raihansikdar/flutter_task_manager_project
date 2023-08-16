import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  bool _signUpInProgress = false;
  bool get signUpInProgress => _signUpInProgress;

  Future<bool> userSignUp({required String email,required String firstName,required String lastName,required String mobile,required String password,required String photo}) async {
    _signUpInProgress = true;
     update();

    Map<String, dynamic> requestBody = <String, dynamic>{
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": ""
    };

    final NetworkResponse response = await NetworkCaller().postRequest(Urls.registration, requestBody);

    _signUpInProgress = false;
     update();

    if (response.isSuccess) {
      return true;
      // _emailControlller.clear();
      // _firstNameControlller.clear();
      // _lastNameControlller.clear();
      // _mobileControlller.clear();
      // _passwordControlller.clear();

      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Registration success!')));
      //}
    } else {
      return false;
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Registration failed!')));
      // }
    }
  }
}