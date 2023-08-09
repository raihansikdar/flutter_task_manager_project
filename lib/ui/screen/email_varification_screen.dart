import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/data/models/network_response.dart';
import 'package:flutter_task_manager_project/data/service/network_caller.dart';
import 'package:flutter_task_manager_project/data/utils/urls.dart';
import 'package:flutter_task_manager_project/ui/screen/auth/otp_varification_screen.dart';
import 'package:flutter_task_manager_project/ui/widgets/screen_background.dart';

class EmailVarificationScreen extends StatefulWidget {
  const EmailVarificationScreen({super.key});

  @override
  State<EmailVarificationScreen> createState() =>
      _EmailVarificationScreenState();
}

class _EmailVarificationScreenState extends State<EmailVarificationScreen> {
  
  
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();


  Future<void> sendOTPToEmail() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.sendOtpToEmail(_emailController.text.trim()));

    _isLoading = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpVarificationScreen(
                    email: _emailController.text.trim())));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Email verification has been failed!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _fromKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(
                width: double.infinity,
                child: _isLoading
                    ? const Center(
                        child: CupertinoActivityIndicator(
                        radius: 14,
                      ))
                    : ElevatedButton(
                        onPressed: () {
                          if (!_fromKey.currentState!.validate()) {
                            return;
                          }else{
                             sendOTPToEmail();
                          }
                         
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
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
