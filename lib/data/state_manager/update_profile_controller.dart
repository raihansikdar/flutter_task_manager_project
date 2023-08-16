import 'package:flutter_task_manager_project/data/models/auth_utility.dart';
import 'package:flutter_task_manager_project/data/models/login_model.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController{
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> updateProfile({required String firstName,required String lastName,required String mobile,required String password}) async {
    _isLoading = true;
     update();

    Map<String, dynamic> requestBody = {
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "photo": ""
    };

    if (password.isNotEmpty) {
      requestBody['password'] = password;
    }

    final NetworkResponse response = await NetworkCaller().postRequest(Urls.updateProfile, requestBody);

    _isLoading = false;
     update();

    if (response.isSuccess) {
      UserData userData = AuthUtility.userInfo.data!;
      userData.firstName = firstName;
      userData.lastName = lastName;
      userData.mobile = mobile;

      AuthUtility.updateUserInfo(userData);
      return true;

    } else {
      return false;

    }
  }
}