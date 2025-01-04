import 'package:flutter/material.dart';
import 'package:lavatory_admin/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://wtxdjnvbmohnhsvplhft.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind0eGRqbnZibW9obmhzdnBsaGZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI4NTczNTUsImV4cCI6MjA0ODQzMzM1NX0.DJoD6XNa-GIyeVmDcMbgoxXL4OeNtozBUIpnf185mT');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
