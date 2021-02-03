import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api/screens/note_modify.dart';
import 'package:rest_api/services/notes_services.dart';
import 'package:rest_api/widgets/note_delete.dart';
import '../models/note_for_listing';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NoteServices get service => GetIt.I<NoteServices>();
  List<NoteForListing> notes = [];
  String formatDateAndTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    // TODO: implement initState
    notes = service.getNotesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => NoteModify()));
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
        separatorBuilder: (_, __) => Divider(
          color: Colors.green,
          height: 1,
        ),
        itemCount: notes.length,
        itemBuilder: (_, index) => Dismissible(
          key: ValueKey(notes[index].noteId),
          direction: DismissDirection.startToEnd,
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (direction) {},
          confirmDismiss: (direction) async {
            // showDialog return future
            final result = await showDialog(
                context: context, builder: (_) => NoteDelete());
            return result;
          },
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => NoteModify(
                        noteId: notes[index].noteId,
                      )));
            },
            title: Text(
              notes[index].noteTitle,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            subtitle: Text(
                "Last edit on  ${formatDateAndTime(notes[index].lastEditDateTime)}"),
          ),
        ),
      ),
    );
  }
}
