import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/detailsField.dart';
import '../components/titleField.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final titleController = TextEditingController();
  final detailsController = TextEditingController();

  Future<void> addNote() async {
    String title = titleController.text.trim();
    String details = detailsController.text.trim();
    int iduser = 3; // Set the user ID according to your authentication system

    if (title.isEmpty || details.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Title and body cannot be empty')),
      );
      return;
    }

    // Create a map representing the note data
    Map<String, dynamic> noteData = {
      'title': title,
      'details': details,
      'iduser': iduser,
    };

    // Send a POST request to the PHP backend
    Uri url = Uri.parse('https://keynotesapps.000webhostapp.com/create.php');
    final response = await http.post(
      url,
      body: json.encode(noteData),
      headers: {'Content-Type': 'application/json'},
    );

    // Check the response from the backend
    if (response.statusCode == 200) {
      // If the request is successful, show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Note saved successfully')),
      );
      Navigator.pop(context);
    } else {
      // If the request fails, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save note')),
      );
    }

    // Clear the text fields after saving the note
    titleController.clear();
    detailsController.clear();
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
          'Add Note',
          style: TextStyle(
            color: theme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        iconTheme: IconThemeData(color: theme.onPrimaryContainer),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TitleField(controller: titleController, focus: true),
              DetailsField(controller: detailsController),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addNote,
        label: const Text('Save Note', style: TextStyle(fontSize: 16)),
        icon: const Icon(Icons.save_rounded),
        elevation: 0,
      ),
    );
  }
}
