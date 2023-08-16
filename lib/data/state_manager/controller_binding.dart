import 'package:flutter_task_manager_project/data/state_manager/add_new_task_controller.dart';
import 'package:flutter_task_manager_project/data/state_manager/cancel_task_controller.dart';
import 'package:flutter_task_manager_project/data/state_manager/complete_task_controller.dart';
import 'package:flutter_task_manager_project/data/state_manager/email_varification_controller.dart';
import 'package:flutter_task_manager_project/data/state_manager/login_controller.dart';
import 'package:flutter_task_manager_project/data/state_manager/new_task_controller.dart';
import 'package:flutter_task_manager_project/data/state_manager/otp_varification_controller.dart';
import 'package:flutter_task_manager_project/data/state_manager/progress_task_controller.dart';
import 'package:flutter_task_manager_project/data/state_manager/reset_password_controller.dart';
import 'package:flutter_task_manager_project/data/state_manager/signup_controller.dart';
import 'package:flutter_task_manager_project/data/state_manager/status_task_controller.dart';
import 'package:flutter_task_manager_project/data/state_manager/summary_card_controller.dart';
import 'package:flutter_task_manager_project/data/state_manager/update_profile_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
    Get.put<SummaryCardController>(SummaryCardController());
    Get.put<NewTaskController>(NewTaskController());
    Get.put<ProgressTaskController>(ProgressTaskController());
    Get.put<CompleteTaskController>(CompleteTaskController());
    Get.put<CancelTaskController>(CancelTaskController());
    Get.put<StatusTaskController>(StatusTaskController());
    Get.put<AddNewTaskController>(AddNewTaskController());
    Get.put<EmailVarificationController>(EmailVarificationController());
    Get.put<OtpVarificationController>(OtpVarificationController());
    Get.put<ResetPasswordController>(ResetPasswordController());
    Get.put<SignUpController>(SignUpController());
    Get.put<UpdateProfileController>(UpdateProfileController());
  }

}