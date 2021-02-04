import 'package:flutter/foundation.dart';

class NoteInsert {
  String noteTitle;
  String noteContent;
  NoteInsert({@required this.noteTitle, @required this.noteContent});

  Map<String, Object> toJson() {
    return {
      "noteTitle": noteTitle,
      "noteContent": noteContent,
    };
  }
}
