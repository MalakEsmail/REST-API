import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api/models/http_response.dart';
import 'package:rest_api/models/note_for_listing.dart';
import 'package:rest_api/screens/note_modify.dart';
import 'package:rest_api/services/notes_services.dart';
import 'package:rest_api/widgets/note_delete.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NoteServices get service => GetIt.I<NoteServices>();
  APIResponse<List<NoteForListing>> _apiResponse;
  bool _isLoading = false;
  String formatDateAndTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    // TODO: implement initState
    _fetchNotes();
    super.initState();
  }

  void _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getNotesList();
    setState(() {
      _isLoading = false;
    });
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
        body: Builder(builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (_apiResponse.error) {
            return Center(child: Text(_apiResponse.errorMsg));
          }

          return ListView.separated(
            separatorBuilder: (_, __) => Divider(
              color: Colors.green,
              height: 1,
            ),
            itemCount: _apiResponse.data.length,
            itemBuilder: (_, index) => Dismissible(
              key: ValueKey(_apiResponse.data[index].noteId),
              direction: DismissDirection.startToEnd,
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (direction) {},
              confirmDismiss: (direction) async {
                // showDialog return future
                final result = await showDialog(
                    context: context, builder: (_) => NoteDelete());
                if (result) {
                  final deleteResult = await service
                      .deleteNotes(_apiResponse.data[index].noteId);

                  var message;
                  if (deleteResult != null && deleteResult.data == true) {
                    message = 'The note was deleted successfully';
                  } else {
                    message = deleteResult?.errorMsg ?? 'An error occured';
                  }

                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text('Done'),
                            content: Text(message),
                            actions: <Widget>[
                              FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ],
                          ));

                  return deleteResult?.data ?? false;
                }
                print(result);
                return result;
              },
              child: ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (_) => NoteModify(
                                noteId: _apiResponse.data[index].noteId,
                              )))
                      .then((_) {
                    _fetchNotes();
                  });
                },
                title: Text(
                  _apiResponse.data[index].noteTitle,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                subtitle: Text(
                    "Last edit on  ${formatDateAndTime(_apiResponse.data[index].lastEditDateTime)}"),
              ),
            ),
          );
        })
        // _isLoading
        // ?

        );
  }
}
