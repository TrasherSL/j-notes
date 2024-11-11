  import 'package:flutter/material.dart';
  import 'package:untitled/database_helper.dart';

  class NoteDetailScreen extends StatefulWidget {
    final Map<String, dynamic>? note;

    NoteDetailScreen({this.note});

    @override
    _NoteDetailScreenState createState() => _NoteDetailScreenState();
  }

  class _NoteDetailScreenState extends State<NoteDetailScreen> {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _contentController = TextEditingController();

    @override
    void initState() {
      super.initState();
      if (widget.note != null) {
        _titleController.text = widget.note!['title'];
        _contentController.text = widget.note!['content'];
      }
    }

    _saveNote() async {
      final title = _titleController.text;
      final content = _contentController.text;

      if (widget.note == null) {
        await DatabaseHelper.instance.createNote({
          'title': title,
          'content': content,
          'created_at': DateTime.now().toString(),
        });
      } else {
        await DatabaseHelper.instance.updateNote({
          'id': widget.note!['id'],
          'title': title,
          'content': content,
          'created_at': widget.note!['created_at'],
        });
      }

      Navigator.pop(context, true); // Return to HomeScreen after saving
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.note == null ? 'Create Note' : 'Edit Note'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content'),
                maxLines: 5,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveNote,
                child: Text(widget.note == null ? 'Create' : 'Update'),
              ),
            ],
          ),
        ),
      );
    }
  }
