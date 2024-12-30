import 'dart:convert';

import 'package:KeyNotes/api_connection/api_connection.dart';
import 'package:KeyNotes/model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../components/authButton.dart';
import '../components/authField.dart';
import 'login.dart'; // Import halaman Login

class SignUp extends StatefulWidget {
  final Function() onTap;
  const SignUp({Key? key, required this.onTap}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final fnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  showAlert(String msg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(msg),
          actions: [
            FilledButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Okay'),
            )
          ],
        );
      },
    );
  }

  validateUserEmail() async{ 
    try {
        var res = await http.post(Uri.parse(API.validateEmail),
        body: {
          'email': emailController.text.trim(),
        },
      );

      if(res.statusCode == 200){
        var resBody = jsonDecode(res.body);

        if (resBody['emailFound'] == true){
          Fluttertoast.showToast(msg: "Email is already in someone else use. Try another email.");
        } else {
          //register and save new user record to db
          registerAndSaveUserRecord();
        }
      }
    } catch (e) {
        print(e.toString());
    }
  }

  registerAndSaveUserRecord() async {
  try {
    // Membuat objek JSON dari data pengguna
    Map<String, dynamic> userData = {
      'fullname': fnameController.text.trim(),
      'email': emailController.text.trim(),
      'no_hp': phoneController.text.trim(),
      'password': passwordController.text.trim(),
    };

    // Mengonversi objek JSON ke dalam format string
    String jsonData = jsonEncode(userData);

    // Mengirim data ke server menggunakan metode POST
    var res = await http.post(
      Uri.parse('https://keynotesapps.000webhostapp.com/register.php'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );

    // Memeriksa status kode respons dari server
    if (res.statusCode == 200) {
      var resBodyOfRegister = jsonDecode(res.body);
      if (resBodyOfRegister['success'] == true) {
        Fluttertoast.showToast(msg: "Congratulations, you have signed up successfully!");
      } else {
        Fluttertoast.showToast(msg: "Your email has been taken, please enter a new email!");
      }
    } else {
      Fluttertoast.showToast(msg: "Server error: ${res.statusCode}");
    }
  } catch (e) {
    showAlert("An error occurred while registering the user: $e");
  }
}
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryContainer,
        centerTitle: true,
        title: Text(
          'Signup',
          style: TextStyle(
            color: theme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text('Happy to see you!', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AuthField(
                        controller: fnameController,
                        hint: 'Full Name',
                        icon: const Icon(Icons.person),
                        password: false,
                        textType: TextInputType.name,
                        initialValue: '',
                      ),
                      AuthField(
                        controller: emailController,
                        hint: 'E-mail',
                        icon: const Icon(Icons.email_outlined),
                        password: false,
                        textType: TextInputType.emailAddress,
                        initialValue: '',
                      ),
                      AuthField(
                        controller: phoneController,
                        hint: 'Contact No.',
                        icon: const Icon(Icons.phone_android_rounded),
                        password: false,
                        textType: TextInputType.phone,
                        initialValue: '',
                      ),
                      AuthField(
                        controller: passwordController,
                        hint: 'Password',
                        icon: const Icon(Icons.lock_outline_rounded),
                        password: true,
                        textType: TextInputType.visiblePassword,
                        initialValue: '',
                      ),
                      const SizedBox(height: 20),
                      AuthButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            registerAndSaveUserRecord();
                          }
                        },
                        name: 'Sign Up',
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          TextButton(
                            onPressed: () {
                              Get.to(() => Login(onTap: widget.onTap));
                            },
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
