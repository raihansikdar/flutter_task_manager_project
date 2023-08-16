import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/state_manager/signup_controller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:flutter_task_manager_project/ui/widgets/screen_background.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailControlller = TextEditingController();
  final TextEditingController _firstNameControlller = TextEditingController();
  final TextEditingController _lastNameControlller = TextEditingController();
  final TextEditingController _mobileControlller = TextEditingController();
  final TextEditingController _passwordControlller = TextEditingController();

  final GlobalKey<FormState> _fromkey = GlobalKey<FormState>();

  final SignUpController _SignUpController = Get.find<SignUpController>();

  bool showClearIcon = false;

  void clearTextfieldIcon() {
    _emailControlller.clear();
    showClearIcon = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _fromkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 64,
                ),
                Text(
                  'Join With Us',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  onChanged: (value) {
                    showClearIcon = value.isNotEmpty; // kichu likle true hobe and icon show hobe
                    setState(() {});
                  },
                  controller: _emailControlller,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: showClearIcon
                        ? GestureDetector(
                            onTap: () => clearTextfieldIcon(),
                            child: const Icon(Icons.close),
                          )
                        : null,
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _firstNameControlller,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'First name',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _lastNameControlller,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Last name',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _mobileControlller,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Mobile',
                  ),
                  validator: (String? value) {
                    if ((value?.isEmpty ?? true) || value!.length < 11) {
                      return 'Enter your valid mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _passwordControlller,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
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
                GetBuilder<SignUpController>(
                  builder: (_) {
                    return SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _SignUpController.signUpInProgress == false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              if (!_fromkey.currentState!.validate()) {
                                return;
                              }
                              _SignUpController.userSignUp(
                                  email: _emailControlller.text.trim(),
                                  firstName: _firstNameControlller.text.trim(),
                                  lastName: _lastNameControlller.text.trim(),
                                  mobile:_mobileControlller.text,
                                  password:_passwordControlller.text,
                                  photo: "").then((value) {
                                    if(value == true){
                                      _emailControlller.clear();
                                      _firstNameControlller.clear();
                                      _lastNameControlller.clear();
                                      _mobileControlller.clear();
                                      _passwordControlller.clear();
                                      Get.snackbar("Success", "Registration success!");
                                    }else{
                                      Get.snackbar("Failed", "Registration failed!");
                                    }
                              });
                            },
                            child: const Icon(Icons.arrow_circle_right_outlined)),
                        // child: _signUpInProgress ? const Center(child: CupertinoActivityIndicator(color: Colors.white,radius: 13.0,),) : const Icon(Icons.arrow_circle_right_outlined)),
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
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Log in')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
