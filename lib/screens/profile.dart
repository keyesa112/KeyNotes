import 'package:KeyNotes/components/authButton.dart';
import 'package:KeyNotes/screens/editProfile.dart';
import 'package:KeyNotes/screens/login.dart';
import 'package:KeyNotes/screens/noteList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: theme.primaryContainer,
        actions: [
          IconButton(
            onPressed: () {
              Get.offAll(() => Login(onTap: () {  },));
            },
            icon: Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.off(() => NoteList());
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_image.png'),
            ),
            SizedBox(height: 20),
            Text(
              "John Doe",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "john.doe@example.com",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            AuthButton(
              onTap: () {
                // Navigasi ke halaman EditProfileScreen saat tombol "Edit Profile" ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
              name: "Edit Profile",
            ),
          ],
        ),
      ),
    );
  }
}
