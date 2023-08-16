import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:get/get.dart';

class OtpVarificationController extends GetxController{
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> verifyOTP({required String email, required String otpText}) async {
    _isLoading = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.otpVerify(email, otpText));

    _isLoading = false;
     update();

    if (response.isSuccess) {
      return true;

    } else {
      return false;

    }
  }
}