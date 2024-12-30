import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../components/noteTile.dart';
import '../screens/addNote.dart';
import '../screens/editNote.dart';
import '../screens/profile.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
    // Start a periodic timer to fetch notes every 30 seconds
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      fetchNotes();
    });
  }

  Future<void> fetchNotes() async {
    final response = await http.get(Uri.parse('https://keynotesapps.000webhostapp.com/get_notes.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        notes = data.cast<Map<String, dynamic>>();
      });
    } else {
      // Handle error
      print('Failed to load notes');
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
        title: const Text(
          'KeyNotes',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Navigate to the Profile screen
              Get.to(() => ProfileScreen());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.account_circle_rounded,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const AddNote());
        },
        label: const Text(
          'Add Note',
          style: TextStyle(fontSize: 16),
        ),
        icon: const Icon(Icons.add_rounded),
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: NoteTile(
                title: note['title'],
                date: note['date'],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditNote(
                        idnotes: note['idnotes'],
                        title: note['title'],
                        date: note['date'],
                        details: note['details'],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
