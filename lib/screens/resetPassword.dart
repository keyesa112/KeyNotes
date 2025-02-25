import 'package:flutter/material.dart';

import '../components/authButton.dart';
import '../components/authField.dart';
import '../components/simpleAlert.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final email = TextEditingController();

  resetPassword() async {
    // You can add your reset password logic here if needed
    showDialog(
      context: context,
      builder: (context) => const SimpleAlert(
        title: 'Reset Link Sent!',
        content: 'Please check your mail inbox',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.primaryContainer,
        centerTitle: true,
        title: Text(
          'Reset Password',
          style: TextStyle(
            color: theme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Enter your email to reset your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 20),
                AuthField(
                  controller: email,
                  hint: 'E-mail',
                  icon: const Icon(Icons.email_outlined),
                  password: false,
                  textType: TextInputType.emailAddress, initialValue: '',
                ),
                const SizedBox(height: 20),
                AuthButton(onTap: resetPassword, name: 'Reset Password'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
