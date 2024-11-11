import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/database_helper.dart';
import 'package:untitled/models/ThemeProvider.dart';

class SettingsScreen extends StatefulWidget {
  final Function refreshNotes; // Constructor parameter to accept the refresh function

  SettingsScreen({required this.refreshNotes}); // Constructor to accept refreshNotes

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Function to reset data (delete all notes)
  _resetData(BuildContext context) async {
    await DatabaseHelper.instance.deleteAllNotes(); // Assuming deleteAllNotes exists
    widget.refreshNotes();  // Refresh the notes on HomeScreen
    Navigator.pop(context);  // Go back to HomeScreen after reset
  }

  @override
  Widget build(BuildContext context) {
    // Access current theme mode from ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          // Dark Mode Toggle
          SwitchListTile(
            title: Text('Dark Mode'),
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),
          // Font Size Adjustment
          ListTile(
            title: Text('Font Size'),
            trailing: DropdownButton<double>(
              value: themeProvider.fontSize, // Assume fontSize is part of ThemeProvider
              onChanged: (value) {
                setState(() {
                  themeProvider.setFontSize(value!); // Set the new font size
                });
              },
              items: [14.0, 16.0, 18.0, 20.0]
                  .map((size) => DropdownMenuItem(
                value: size,
                child: Text('$size px'),
              ))
                  .toList(),
            ),
          ),
          // Notifications Toggle
          SwitchListTile(
            title: Text('Enable Notifications'),
            value: themeProvider.notificationsEnabled, // Assuming it's part of ThemeProvider
            onChanged: (value) {
              setState(() {
                themeProvider.toggleNotifications(value); // Toggle notification setting
              });
            },
          ),
          // App Version Info
          ListTile(
            title: Text('App Version'),
            subtitle: Text('1.1.0'),
          ),
          // Contact Support (you can implement this functionality as needed)
          // Reset Data Option
          ListTile(
            title: Text('Reset Data'),
            subtitle: Text('Clear all saved notes and settings'),
            onTap: () {
              // Confirm before resetting data
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Reset'),
                    content: Text('Are you sure you want to reset all data? This will clear all saved notes and settings.'),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                      ),
                      TextButton(
                        child: Text('Reset'),
                        onPressed: () {
                          _resetData(context); // Reset data and go back
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
