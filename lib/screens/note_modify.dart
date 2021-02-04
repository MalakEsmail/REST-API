import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api/models/note.dart';
import 'package:rest_api/models/note_insert.dart';
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
    if (isEditing) {
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
    }

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
            ? Center(child: CircularProgressIndicator())
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
                      onPressed: () async {
                        if (isEditing) {
                          final note = NoteManuplation(
                              noteContent: _contentController.text,
                              noteTitle: _titleController.text);
                          final result =
                              await service.updateNotes(widget.noteId, note);
                          final title = 'Done';
                          final text = result.error
                              ? (result.errorMsg ?? 'An error occurred')
                              : 'Your note was updated';

                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text(title),
                                    content: Text(text),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  )).then((data) {
                            if (result.data) {
                              Navigator.of(context).pop();
                            }
                          });
                        } else {
                          // create note
                          final note = NoteManuplation(
                              noteContent: _contentController.text,
                              noteTitle: _titleController.text);
                          final result = await service.createNotes(note);
                          final title = 'Done';
                          final text = result.error
                              ? (result.errorMsg ?? 'An error occurred')
                              : 'Your note was created';

                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text(title),
                                    content: Text(text),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  )).then((data) {
                            if (result.data) {
                              Navigator.of(context).pop();
                            }
                          });
                        }

                        // Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
