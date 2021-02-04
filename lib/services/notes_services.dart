import 'dart:convert';

import 'package:rest_api/models/http_response.dart';
import 'package:http/http.dart' as http;
import '../models/note_for_listing';

class NoteServices {
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {'apiKey': '75066809-aa65-4555-b2de-7985875820d3'};
  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(API + '/notes', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];

        for (var item in jsonData) {
          final note = NoteForListing(
              noteId: item['noteID'],
              noteTitle: item['noteTitle'],
              createDateTime: item['createDateTime'] != null
                  ? DateTime.parse(item['createDateTime'])
                  : null,
              lastEditDateTime: item['latestEditDateTime'] != null
                  ? DateTime.parse(item['latestEditDateTime'])
                  : DateTime.parse(item['createDateTime']));
          notes.add(note);
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(
          error: true, errorMsg: 'An Error Occured');
    }).catchError((_) => APIResponse<List<NoteForListing>>(
        error: true, errorMsg: 'An Error Occured'));
  }
}
