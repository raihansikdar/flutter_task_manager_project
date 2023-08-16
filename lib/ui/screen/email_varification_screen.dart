import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/state_manager/email_varification_controller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:flutter_task_manager_project/ui/screen/auth/otp_varification_screen.dart';
import 'package:flutter_task_manager_project/ui/widgets/screen_background.dart';
import 'package:get/get.dart';

class EmailVarificationScreen extends StatefulWidget {
  const EmailVarificationScreen({super.key});

  @override
  State<EmailVarificationScreen> createState() =>
      _EmailVarificationScreenState();
}

class _EmailVarificationScreenState extends State<EmailVarificationScreen> {
  
  
  final TextEditingController _emailController = TextEditingController();

  final EmailVarificationController _emailVarificationController = Get.find<EmailVarificationController>();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _fromKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 64.0,
              ),
              Text(
                "Your Email Address",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                "Six digit varification code will to send your email adderss",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                keyboardAppearance: Brightness.dark,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please Enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              GetBuilder<EmailVarificationController>(
                builder: (_) {
                  return SizedBox(
                    width: double.infinity,
                    child: _emailVarificationController.isLoading
                        ? const Center(
                            child: CupertinoActivityIndicator(
                            radius: 14,
                          ))
                        : ElevatedButton(
                            onPressed: () {
                              if (!_fromKey.currentState!.validate()) {
                                return;
                              }else{
                                _emailVarificationController.sendOTPToEmail(
                                    email: _emailController.text.trim()).then((value) {
                                   if(value == true){
                                     Get.snackbar("OTP", "has been send to your email");
                                     Get.to(()=>OtpVarificationScreen(email: _emailController.text.trim()));
                                   }else{
                                     Get.snackbar("Faild", "OTP doesn't sent");
                                   }
                                });
                              }

                            },
                            child: const Icon(Icons.arrow_circle_right_outlined),
                          ),
                  );
                }
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("log in"))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
