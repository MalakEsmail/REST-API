import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api/screens/note_list.dart';
import 'package:rest_api/services/notes_services.dart';

void setupLocator() {
  // to make only one instance
  GetIt.I.registerLazySingleton(() => NoteServices());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NoteList(),
    );
  }
}
