import 'package:flutter/material.dart';
import 'package:untitled/database_helper.dart';
import 'package:untitled/models/note_detail_screen.dart';
import 'package:untitled/models/search.dart';
import 'package:untitled/models/SettingsScreen.dart';
import 'package:untitled/models/AboutScreen.dart';
import 'package:untitled/models/ThemeProvider.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/home_screen.dart';
import 'package:untitled/models/note_detail_screen.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'J-Notes',
      theme: ThemeData(
        brightness: themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(
          refreshNotes: () {

            final homeScreenState = context.findAncestorStateOfType<HomeScreenState>();
            homeScreenState?.refreshNotes();
          },
        ),
        '/create': (context) => NoteDetailScreen(),
        '/search': (context) => SearchScreen(),
        '/settings': (context) => SettingsScreen(
          refreshNotes: () {
            final homeScreenState = context.findAncestorStateOfType<HomeScreenState>();
            homeScreenState?.refreshNotes();
          },
        ),
        '/about': (context) => AboutScreen(),
      },
    );
  }
}
