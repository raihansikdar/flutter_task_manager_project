import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/ui/screen/auth/login_screen.dart';
import 'package:flutter_task_manager_project/ui/screen/auth/reset_password_screen.dart';
import 'package:flutter_task_manager_project/ui/widgets/screen_background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVarificationScreen extends StatelessWidget {
  const OtpVarificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 64,
            ),
            Text(
              "Pin varification",
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
            PinCodeTextField(
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  inactiveColor: Colors.blue,
                  selectedFillColor: Colors.white,
                  selectedColor: Colors.white),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              enablePinAutofill: true,
              cursorColor: Colors.green,
              onCompleted: (v) {},
              onChanged: (value) {},
              beforeTextPaste: (text) {
            //    print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
              appContext: context,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ResetPasswordScreen()));
                },
                child: const Text("Verify"),
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
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false);
                    },
                    child: const Text("Sign up"))
              ],
            )
          ],
        ),
      )),
    );
  }
}
