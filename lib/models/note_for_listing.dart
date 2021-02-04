class NoteForListing{
    String noteId;
    String noteTitle;
    DateTime createDateTime;
    DateTime lastEditDateTime;
    NoteForListing({this.noteId,this.noteTitle,this.createDateTime,this.lastEditDateTime});
    factory NoteForListing.fromJson(Map<String,dynamic> item){
        return NoteForListing(
              noteId: item['noteID'],
              noteTitle: item['noteTitle'],
              createDateTime: item['createDateTime'] != null
                  ? DateTime.parse(item['createDateTime'])
                  : null,
              lastEditDateTime: item['latestEditDateTime'] != null
                  ? DateTime.parse(item['latestEditDateTime'])
                  : DateTime.parse(item['createDateTime']));

    }
}