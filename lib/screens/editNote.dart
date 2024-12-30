import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/detailsField.dart';
import '../components/titleField.dart';

class EditNote extends StatefulWidget {
  final String idnotes;
  final String title;
  final String details;
  final String date;

  const EditNote({
    Key? key,
    required this.idnotes,
    required this.title,
    required this.details,
    required this.date,
  }) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late final TextEditingController titleController;
  late final TextEditingController detailsController;
  late final String time;
  late final String noteID;

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with received data
    titleController = TextEditingController(text: widget.title);
    detailsController = TextEditingController(text: widget.details);
    time = widget.date;
    noteID = widget.idnotes;
  }

  Future<void> editNote() async {
    final response = await http.post(
      Uri.parse('https://keynotesapps.000webhostapp.com/update.php'),
      body: jsonEncode(<String, String>{
        'id': noteID,
        'title': titleController.text,
        'details': detailsController.text,
        'date': time,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Successfully updated the note
      print('Note updated: ${response.body}');
      Get.back();
    } else {
      // Failed to update the note
      print('Failed to update note: ${response.body}');
    }
  }

  Future<void> deleteNote() async {
    final response = await http.post(
      Uri.parse('https://keynotesapps.000webhostapp.com/delete.php'),
      body: jsonEncode(<String, String>{
        'id': noteID,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Successfully deleted the note
      print('Note deleted: ${response.body}');
      Get.back();
    } else {
      // Failed to delete the note
      print('Failed to delete note: ${response.body}');
    }
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
          time,
          style: TextStyle(
            color: theme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(onPressed: deleteNote, icon: const Icon(Icons.delete)),
        ],
        iconTheme: IconThemeData(color: theme.onPrimaryContainer),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TitleField(controller: titleController, focus: false),
              DetailsField(controller: detailsController),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: editNote,
        label: const Text('Save Note', style: TextStyle(fontSize: 16)),
        icon: const Icon(Icons.save_rounded),
        elevation: 0,
      ),
    );
  }
}
