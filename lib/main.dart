import 'package:flutter/material.dart';
import 'package:todoist_test/ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenData = ScreenData(title: 'Todoist');

    return MaterialApp(
      title: 'Todoist test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(screenData: screenData),
    );
  }
}
