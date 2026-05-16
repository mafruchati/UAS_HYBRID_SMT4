import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:uas_hybrid/login_page.dart'; 

void main() {
  runApp(const MyApp());
=======
import 'package:implementasi_busgo/halaman_login/halaman_login.dart';

void main() {
  runApp(const MyApp()); 
>>>>>>> 90433fca3c1efbb82d8c3f6d080e4a0374c844d4
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'BusGo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Di sini kita langsung panggil LoginPage()
      home: LoginPage(), 
=======
      title: 'BusGo',
      debugShowCheckedModeBanner: false,
      home: LoginPage(), // Pastikan LoginPage sudah diimport
>>>>>>> 90433fca3c1efbb82d8c3f6d080e4a0374c844d4
    );
  }
}