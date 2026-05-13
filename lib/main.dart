import 'package:flutter/material.dart';
import 'package:implementasi_busgo/pemesanan/pemilihan%20kursi.dart';




void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BusGo',
      debugShowCheckedModeBanner: false,
      home: (SeatSelectionPage()),
    );
  }
}

