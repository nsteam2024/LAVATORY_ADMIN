import 'package:flutter/material.dart';
import 'package:lavatory_admin/homescreen.dart';
import 'package:lavatory_admin/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: LaundryAppUI(),
    );
  }
}
