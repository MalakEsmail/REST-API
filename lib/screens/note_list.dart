import 'package:flutter/material.dart';
import 'package:rest_api/screens/note_modify.dart';
import 'package:rest_api/widgets/note_delete.dart';
import '../models/note_for_listing';

class NoteList extends StatelessWidget {
  final notes = [
    new NoteForListing(
        noteId: '1',
        noteTitle: 'Note 1',
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now()),
    new NoteForListing(
        noteId: '2',
        noteTitle: 'Note 2',
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now()),
    new NoteForListing(
        noteId: '3',
        noteTitle: 'Note 3',
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now()),
  ];
  String formatDateAndTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
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
