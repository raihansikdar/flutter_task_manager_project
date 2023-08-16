import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:get/get.dart';

class EmailVarificationController extends GetxController{
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> sendOTPToEmail({required String email}) async {
    _isLoading = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.sendOtpToEmail(email));

    _isLoading = false;
    update();

    if (response.isSuccess) {
       return true;
      // if (mounted) {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => OtpVarificationScreen(
      //               email: email)));
      // }
    } else {
      return false;
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //       content: Text('Email verification has been failed!')));
      // }
    }
  }
}