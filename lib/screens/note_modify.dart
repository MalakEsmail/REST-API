import 'package:flutter/material.dart';

class NoteModify extends StatelessWidget {
  final String noteId;
  bool get isEditing => noteId != null;
  NoteModify({this.noteId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Note' : 'Create Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Note Title'),
            ),
            Container(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Note Content'),
            ),
            Container(
              height: 8,
            ),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
