import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/services/db_provider.dart';
import 'package:notes/views/all_notes/all_notes_screen.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFFFDAC7),
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  // await deleteDatabase(join(await getDatabasesPath(), 'notes_app_database.db'));
  await DatabaseProvider.init();
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFFFFDAC7),
        textTheme: TextTheme(
          headline1: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            fontSize: 18,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const NotesScreen(),
    );
  }
}
