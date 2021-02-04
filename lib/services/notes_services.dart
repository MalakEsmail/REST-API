import 'dart:convert';

import 'package:rest_api/models/http_response.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/models/note.dart';
import 'package:rest_api/models/note_for_listing.dart';

class NoteServices {
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {'apiKey': '75066809-aa65-4555-b2de-7985875820d3'};

  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(API + '/notes', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];

        for (var item in jsonData) {
          notes.add(NoteForListing.fromJson(item));
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(
          error: true, errorMsg: 'An Error Occured');
    }).catchError((_) => APIResponse<List<NoteForListing>>(
        error: true, errorMsg: 'An Error Occured'));
  }

  Future<APIResponse<Note>> getNotes(String noteId) {
    return http.get(API + '/notes/' + noteId, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        final note = Note(
            noteId: jsonData['noteID'],
            noteTitle: jsonData['noteTitle'],
            createDateTime: jsonData['createDateTime'] != null
                ? DateTime.parse(jsonData['createDateTime'])
                : null,
            lastEditDateTime: jsonData['latestEditDateTime'] != null
                ? DateTime.parse(jsonData['latestEditDateTime'])
                : DateTime.parse(jsonData['createDateTime']));

        return APIResponse<Note>(data: note);
      }
      return APIResponse<Note>(error: true, errorMsg: 'An Error Occured');
    }).catchError(
        (_) => APIResponse<Note>(error: true, errorMsg: 'An Error Occured'));
  }
}
