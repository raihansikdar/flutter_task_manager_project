import 'package:flutter/material.dart';
import 'package:flutter_task_manager_project/ui/screen/auth/otp_varification_screen.dart';
import 'package:flutter_task_manager_project/ui/widgets/screen_background.dart';

class EmailVarificationScreen extends StatelessWidget {
  const EmailVarificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
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
            const TextField(
              keyboardType: TextInputType.emailAddress,
              keyboardAppearance: Brightness.dark,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OtpVarificationScreen(),
                    ),
                  );
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
                    child: const Text("Sign up"))
              ],
            )
          ],
        ),
      )),
    );
  }
}
