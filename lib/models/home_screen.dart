import 'package:flutter/material.dart';
import 'package:untitled/database_helper.dart';
import 'package:untitled/models/note_detail_screen.dart';
import 'package:untitled/models/SettingsScreen.dart';
import 'package:untitled/models/ThemeProvider.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/AboutScreen.dart';
class HomeScreen extends StatefulWidget {
  final Function refreshNotes; // Accept refreshNotes as a parameter
  HomeScreen({required this.refreshNotes});

  @override
  HomeScreenState createState() => HomeScreenState(); // Change _HomeScreenState to HomeScreenState
}

class HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  _loadNotes() async {
    final notes = await DatabaseHelper.instance.getNotes();
    setState(() {
      _notes = notes;
    });
  }

  _deleteNote(int id) async {
    await DatabaseHelper.instance.deleteNote(id);
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('J-Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search').then((_) {
                _loadNotes(); // Refresh notes after search
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(refreshNotes: _loadNotes), // Pass _loadNotes directly
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.info), // Add About icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutScreen(), // Navigate to AboutScreen
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          return ListTile(
            title: Text(
              note['title'],
              style: TextStyle(fontSize: themeProvider.fontSize),
            ),
            subtitle: Text(
              note['content'],
              style: TextStyle(fontSize: themeProvider.fontSize),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteDetailScreen(note: note),
                ),
              ).then((_) {
                _loadNotes(); // Refresh after navigating back
              });
            },
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteNote(note['id']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create').then((_) {
            _loadNotes(); // Refresh after creating a new note
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Expose refreshNotes as a public method
  void refreshNotes() {
    _loadNotes();
  }
}
