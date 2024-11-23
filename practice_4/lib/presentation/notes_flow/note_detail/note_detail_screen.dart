import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:practice_4/presentation/notes_flow/notes_model.dart';

class NoteDetailScreen extends StatefulWidget {
  final int index;

  NoteDetailScreen({required this.index});

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late final NotesModel model;
  late final Note note;

  @override
  void initState() {
    super.initState();
    model = Provider.of<NotesModel>(context, listen: false);
    note = model.notes[widget.index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title.isEmpty ? 'New Note' : note.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                note.title = value;
                model.updateNote(widget.index, note);
              },
              decoration: InputDecoration(labelText: 'Title'),
            ),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  note.text = value;
                  model.updateNote(widget.index, note);
                },
                decoration: InputDecoration(labelText: 'Text'),
                maxLines: null,
                expands: true,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (note.title.isEmpty) {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a title')),
                  );
                } else {
                  model.deleteNote(widget.index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Note deleted')),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}