import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api/models/note.dart';
import 'package:rest_api/services/notes_services.dart';

class NoteModify extends StatefulWidget {
  final String noteId;
  NoteModify({this.noteId});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteId != null;
  NoteServices get service => GetIt.I<NoteServices>();
  String errorMsg;
  Note note;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    // TODO: implement initState
    service.getNotes(widget.noteId).then((response) {
      setState(() {
        isLoading = false;
      });
      if (response.error) {
        errorMsg = response.errorMsg ?? 'An error occurred';
      }
      note = response.data;
      _titleController.text = note.noteTitle;
      _contentController.text = note.noteContent;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Note' : 'Create Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(hintText: 'Note Title'),
                  ),
                  Container(
                    height: 8,
                  ),
                  TextField(
                    controller: _contentController,
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
