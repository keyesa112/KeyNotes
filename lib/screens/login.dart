import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:KeyNotes/screens/noteList.dart';
import 'package:KeyNotes/screens/signup.dart';
import 'package:KeyNotes/model/user.dart';

import '../components/authField.dart';
import '../components/authButton.dart';
import '../screens/resetPassword.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  final Function() onTap;
  const Login({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

  Future<void> login() async {
    try {
      // Membuat objek JSON dari data login
      Map<String, dynamic> loginData = {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      };

      // Mengonversi objek JSON ke dalam format string
      String jsonData = jsonEncode(loginData);

      // Mengirim data ke server menggunakan metode POST
      var res = await http.post(
        Uri.parse('https://keynotesapps.000webhostapp.com/login.php'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );

      // Memeriksa status kode respons dari server
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['status'] == 'success') {
          // Jika login berhasil, tampilkan pesan sukses
          Fluttertoast.showToast(msg: "Login successful!");
          Get.offAll(NoteList());
        } else {
          // Jika login gagal, tampilkan pesan error dari server
          Fluttertoast.showToast(msg: "Login failed: ${resBody['message']}");
        }
      } else {
        // Jika terjadi kesalahan server, tampilkan pesan error
        Fluttertoast.showToast(msg: "Server error: ${res.statusCode}");
      }
    } catch (e) {
      // Jika terjadi kesalahan selama proses login, tampilkan pesan error
      Fluttertoast.showToast(msg: "An error occurred: $e");
    }
  }

    void showAlert(String msg) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(msg),
            actions: [
              FilledButton(onPressed: () => Get.back(), child: const Text('Okay')),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.primaryContainer,
        title: Text(
          'Login',
          style: TextStyle(
            color: theme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text('Happy to see you again!', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 20),
                AuthField(
                  controller: emailController,
                  hint: 'E-mail',
                  icon: const Icon(Icons.email_outlined),
                  password: false,
                  textType: TextInputType.emailAddress, initialValue: '',
                ),
                AuthField(
                  controller: passwordController,
                  hint: 'Password',
                  icon: const Icon(Icons.lock_outline_rounded),
                  password: true,
                  textType: TextInputType.visiblePassword, initialValue: '',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(const ResetPassword());
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                AuthButton(
                  onTap: () {
                    login();
                  },
                  name: 'Login',
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        // Navigasi ke halaman SignUp saat tombol "Sign Up" ditekan
                        Get.to(() => SignUp(onTap: () {  },));
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}