import 'package:flutter/material.dart';
import 'package:untitled/database_helper.dart';
import 'package:untitled/models/note_detail_screen.dart';
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredNotes = [];

  _searchNotes(String query) async {
    final notes = await DatabaseHelper.instance.getNotes();
    setState(() {
      _filteredNotes = notes
          .where((note) =>
      note['title'].toLowerCase().contains(query.toLowerCase()) ||
          note['content'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Notes')),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: _searchNotes,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredNotes.length,
              itemBuilder: (context, index) {
                final note = _filteredNotes[index];
                return ListTile(
                  title: Text(note['title']),
                  subtitle: Text(note['content']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteDetailScreen(note: note),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
