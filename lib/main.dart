import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/saved_screen.dart';
import 'screens/search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TOT APP',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      routes: {
        '/saved': (context) => SavedScreen(),
        '/search': (context) => SearchScreen(),
      },
    );
  }
}
