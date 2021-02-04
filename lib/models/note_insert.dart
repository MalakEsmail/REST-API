import 'package:flutter/foundation.dart';

class NoteManuplation {
  String noteTitle;
  String noteContent;
  NoteManuplation({@required this.noteTitle, @required this.noteContent});

  Map<String, Object> toJson() {
    return {
      "noteTitle": noteTitle,
      "noteContent": noteContent,
    };
  }
}
