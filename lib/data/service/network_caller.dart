import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/app.dart';
import 'package:flutter_task_manager_project/data/models/auth_utility.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/ui/screen/auth/login_screen.dart';
import 'package:http/http.dart';

class NetworkCaller {
  ///----------------------------------Get Method---------------------------------------
  Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url),headers: {'token':AuthUtility.userInfo.token.toString()});
      
      log(response.statusCode.toString());
      log(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(isSuccess: true,statusCode: response.statusCode,body: jsonDecode(response.body));
      }else if (response.statusCode == 401) {
        gotoLogin();
      } else {
        return NetworkResponse(isSuccess: false, statusCode: response.statusCode, body: null);
      }
    } catch (e) {
      log(e.toString());
      // throw Exception("$e");
    }
    return NetworkResponse(isSuccess: false, statusCode: -1, body: null);
  }

  ///----------------------------------Post Method---------------------------------------
  Future<NetworkResponse> postRequest(String url, Map<String, dynamic> body,{bool isLogin = false}) async {
    try {
      Response response = await post(Uri.parse(url),headers: {'Content-type': 'application/json','token':AuthUtility.userInfo.token.toString()},body: jsonEncode(body));
      
      log(response.statusCode.toString());
      log(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(isSuccess: true,statusCode: response.statusCode,body: jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        if(isLogin== false){
          gotoLogin();
        }
      } else {
        return NetworkResponse(isSuccess: false, statusCode: response.statusCode, body: null);
      }
    } catch (e) {
      log(e.toString());
      // throw Exception("$e");
    }
    return NetworkResponse(isSuccess: false, statusCode: -1, body: null);
  }
   Future<void> gotoLogin() async {
    await AuthUtility.clearUserInfo();
    Navigator.pushAndRemoveUntil(
         TaskManagerApp.globalKey.currentContext!, // TaskManagerApp.globalKey.currentState!.context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }
}
// single responsibility principle