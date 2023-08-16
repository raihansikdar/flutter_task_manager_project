import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController{
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> resetPassword({required String email,required String otpText,required String password}) async {
    _isLoading = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otpText,
      "password": password,
    };
    final NetworkResponse response = await NetworkCaller().postRequest(Urls.resetPassword, requestBody);
    _isLoading = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}