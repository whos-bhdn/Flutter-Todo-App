import 'package:flutter/material.dart';
import 'package:task_todo/pages/home.dart';
import 'package:task_todo/pages/mainScreen.dart';

void main() => runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.grey,
    ),
    initialRoute: '/one',
    home: MainScreen(),
    routes: {
      '/one': (context) => MainScreen(),
      '/todo': (context) => Home()
    },
));

