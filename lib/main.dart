import 'package:flutter/material.dart';
import 'package:implementasi_busgo/halaman_login/halaman_login.dart';

void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BusGo',
      debugShowCheckedModeBanner: false,
      home: LoginPage(), // Pastikan LoginPage sudah diimport
    );
  }
}