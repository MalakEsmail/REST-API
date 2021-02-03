import '../models/note_for_listing';

class NoteServices {
  List<NoteForListing> getNotesList() {
    return [
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
  }
}
