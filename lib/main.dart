import 'package:KeyNotes/controllers/UserController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KeyNotes/screens/noteList.dart';

import 'colors.dart';
import 'package:KeyNotes/screens/signup.dart';
import 'package:KeyNotes/screens/login.dart';

void main() async{
    // Initialize UserController
  Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KeyNotes',
      theme: ThemeData(
        colorScheme: lightColorScheme,
        fontFamily: GoogleFonts.mukta().fontFamily,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        fontFamily: GoogleFonts.mukta().fontFamily,
        useMaterial3: true
      ),
      themeMode: ThemeMode.system,
      home: SignUp(
        onTap: () {
          Navigator.push(
            context,
              MaterialPageRoute(builder: (context) => Login(onTap: () {
          Navigator.pushReplacement(
            context,
              MaterialPageRoute(builder: (context) => NoteList()),
        );
          },
        )
      ),
    );
  },
),
    );
  }
}
