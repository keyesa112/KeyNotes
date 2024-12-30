import 'package:flutter/material.dart';
import '../components/authButton.dart'; // Mengimpor AuthButton dari lokasi yang benar
import '../components/authField.dart'; // Mengimpor AuthField dari lokasi yang benar

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final TextEditingController emailController = TextEditingController(); // Controller untuk field email

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: theme.primaryContainer,
        iconTheme: IconThemeData(color: Colors.black), // Mengubah warna tombol back (panah) menjadi putih
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            AuthField(
              controller: TextEditingController(), // Controller untuk field nama
              hint: 'Full Name',
              icon: const Icon(Icons.person_outline),
              password: false,
              textType: TextInputType.text,
              initialValue: "John Doe",
            ),
            SizedBox(height: 8),
            AuthField(
              controller: emailController,
              hint: 'E-mail',
              icon: const Icon(Icons.email_outlined),
              password: false,
              textType: TextInputType.emailAddress,
              initialValue: 'john.doe@example.com',
            ),
            SizedBox(height: 16),
            AuthButton(
              onTap: () {
                // Logika untuk menyimpan perubahan profil
                Navigator.pop(context); // Kembali ke halaman profil setelah menyimpan
              },
              name: "Save", // Text yang ditampilkan pada tombol
            ),
          ],
        ),
      ),
    );
  }
}
