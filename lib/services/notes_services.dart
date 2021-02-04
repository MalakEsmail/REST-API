import 'dart:convert';
import 'package:rest_api/models/http_response.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/models/note.dart';
import 'package:rest_api/models/note_for_listing.dart';
import 'package:rest_api/models/note_insert.dart';

class NoteServices {
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {
    'apiKey': '75066809-aa65-4555-b2de-7985875820d3',
    'Content-Type': 'application/json'
  };

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

        return APIResponse<Note>(data: Note.fromJson(jsonData));
      }
      return APIResponse<Note>(error: true, errorMsg: 'An Error Occured');
    }).catchError(
        (_) => APIResponse<Note>(error: true, errorMsg: 'An Error Occured'));
  }

  Future<APIResponse<bool>> createNotes(NoteManuplation item) {
    return http
        .post(API + '/notes',
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMsg: 'An Error Occured');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMsg: 'An Error Occured'));
  }

  Future<APIResponse<bool>> updateNotes(String noteId, NoteManuplation item) {
    return http
        .put(API + '/notes/' + noteId,
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMsg: 'An Error Occured');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMsg: 'An Error Occured'));
  }
}
