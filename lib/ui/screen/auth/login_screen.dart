import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/data/models/auth_utility.dart';
import 'package:flutter_task_manager_project/data/models/login_model.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/state_manager/login_controller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:flutter_task_manager_project/ui/screen/bottom_nav_base_screen.dart';
import 'package:flutter_task_manager_project/ui/screen/email_varification_screen.dart';
import 'package:flutter_task_manager_project/ui/screen/auth/sign_up_screen.dart';
import 'package:get/get.dart';
import '../../widgets/screen_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final  TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  final LoginController _loginController = Get.find<LoginController>();

  bool showEmailClearIcon = false;
  bool showPasswordClearIcon = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _fromKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Get Started With",
                // style: TextStyle(
                //     fontSize: 24,
                //     color: Colors.black,
                //     fontWeight: FontWeight.w500),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                onChanged: (value) {
                  showEmailClearIcon = value.isNotEmpty;
                  if (mounted) {
                    setState(() {});
                  }
                },
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: showEmailClearIcon
                        ? GestureDetector(
                            onTap: () {
                              _emailController.clear();
                              showEmailClearIcon = false;
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            child: const Icon(Icons.close))
                        : null),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please Enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                onChanged: (value) {
                  showPasswordClearIcon = value.isNotEmpty;
                  if (mounted) {
                    setState(() {});
                  }
                },
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: showPasswordClearIcon
                      ? GestureDetector(
                          onTap: () {
                            _passwordController.clear();
                            showPasswordClearIcon = false;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: const Icon(Icons.close))
                      : null,
                ),
                validator: (String? value) {
                  if ((value?.isEmpty ?? true) || value!.length < 5) {
                    return 'Enter a password more than 6 letters';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              GetBuilder<LoginController>(builder: (loginController) {
                return SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: loginController.loginInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_fromKey.currentState!.validate()) {
                          return;
                        } else {
                          loginController
                              .login(
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              ).then((resultFromLogin) {
                               if(resultFromLogin == true){
                                 Get.to(()=> const BottomNavBaseScreen());
                               }else{
                                 Get.snackbar("Faild", "Incorrect email or password");
                               }
                          });
                        }
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Get.to(() => const EmailVarificationScreen());

                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  TextButton(
                      onPressed: () {

                        Get.to(() => const SignUpScreen());
                      },
                      child: const Text("Sign up"))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
