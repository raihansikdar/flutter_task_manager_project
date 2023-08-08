import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/ui/widgets/screen_background.dart';
import 'package:flutter_task_manager_project/ui/widgets/user_profile_banner.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailControlller = TextEditingController();
  final TextEditingController _firstNameControlller = TextEditingController();
  final TextEditingController _lastNameControlller = TextEditingController();
  final TextEditingController _mobileControlller = TextEditingController();
  final TextEditingController _passwordControlller = TextEditingController();

  final GlobalKey<FormState> _fromkey = GlobalKey<FormState>();

  bool _signUpInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SingleChildScrollView(
        child: Form(
          key: _fromkey,
          child: Column(
            children: [
              const UserProfileBanner(isUpdateScreen: true),
              Padding(
                padding: const EdgeInsets.all(16.0),
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
                      height: 14,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            color: Colors.grey,
                            child: const Text(
                              "Photo",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Text(""),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: _emailControlller,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      decoration: const InputDecoration(
                        hintText: 'Email',
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
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _signUpInProgress == false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              if (!_fromkey.currentState!.validate()) {
                                return;
                              }
                              //userSignUp();
                            },
                            child:
                                const Icon(Icons.arrow_circle_right_outlined)),
                        // child: _signUpInProgress ? const Center(child: CupertinoActivityIndicator(color: Colors.white,radius: 13.0,),) : const Icon(Icons.arrow_circle_right_outlined)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
