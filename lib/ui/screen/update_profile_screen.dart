import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/data/models/auth_utility.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:flutter_task_manager_project/ui/widgets/screen_background.dart';
import 'package:flutter_task_manager_project/ui/widgets/user_profile_banner.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/login_model.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  UserData userData =
      AuthUtility.userInfo.data!; // bar bar AuthUtility.userInfo.data likbona

  final TextEditingController _emailControlller = TextEditingController();
  final TextEditingController _firstNameControlller = TextEditingController();
  final TextEditingController _lastNameControlller = TextEditingController();
  final TextEditingController _mobileControlller = TextEditingController();
  final TextEditingController _passwordControlller = TextEditingController();

  final GlobalKey<FormState> _fromkey = GlobalKey<FormState>();
  XFile? imageFile;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _emailControlller.text = userData.email ?? '';
    _firstNameControlller.text = userData.firstName ?? '';
    _lastNameControlller.text = userData.lastName ?? '';
    _mobileControlller.text = userData.mobile ?? '';
  }

  Future<void> updateProfile() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestBody = {
      "firstName": _firstNameControlller.text.trim(),
      "lastName": _lastNameControlller.text.trim(),
      "mobile": _mobileControlller.text.trim(),
      "photo": ""
    };

    if (_passwordControlller.text.isNotEmpty) {
      requestBody['password'] = _passwordControlller.text;
    }

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.updateProfile, requestBody);

    _isLoading = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      userData.firstName = _firstNameControlller.text.trim();
      userData.lastName = _lastNameControlller.text.trim();
      userData.mobile = _mobileControlller.text.trim();

      AuthUtility.updateUserInfo(userData);
      _passwordControlller.clear();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Profile updated!')));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile update failed! Try again.')));
      }
    }
  }

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
                    InkWell(
                      onTap: () {
                        pickImageFromGallery(); // call method
                      },
                      child: Container(
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
                              width: 14,
                            ),
                            //Text(imageFile?.name ?? '')

                            Visibility(
                                visible: imageFile != null,
                                child: Text(imageFile?.name ?? '')),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: _emailControlller,
                      keyboardType: TextInputType.emailAddress,
                      readOnly: true,
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
                      // validator: (String? value) {
                      //   if ((value?.isEmpty ?? true) || value!.length < 5) {
                      //     return 'Enter a password more than 6 letters';
                      //   }
                      //   return null;
                      // },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _isLoading == false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              if (!_fromkey.currentState!.validate()) {
                                return;
                              }
                              updateProfile();
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

  // Function to pick an image from the gallery
  void pickImageFromGallery() {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = xFile;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }
}
