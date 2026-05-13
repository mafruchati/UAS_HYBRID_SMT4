import 'package:flutter/material.dart';
import 'package:implementasi_busgo/halaman%20utama/bantuan.dart';
import 'package:implementasi_busgo/halaman%20utama/profil.dart';
import 'package:implementasi_busgo/halaman%20utama/tiket.dart';
import 'package:implementasi_busgo/pemesanan/tabel%20keberangkatan.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  String selectedDate = 'Hari Ini';

  final fromController = TextEditingController();
  final toController = TextEditingController();

  void onNavTap(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PemesananScreen()),
      );
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => BantuanPage()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B7BFF),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onNavTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff2B7BFF),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num_outlined),
            label: 'Tiket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Bantuan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card utama
            Container(
              decoration: BoxDecoration(
                color: Color(0xff2B7BFF),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Top bar icon bus and bell icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.directions_bus,
                          color: const Color.fromARGB(255, 84, 92, 243),
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Text Hello Girl! and subtext
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Hello Guys!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'where you want go.',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  //FROM & TO
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: fromController,
                          decoration: inputField('Dari', Icons.directions_bus),
                        ),
                        Divider(height: 1),
                        TextField(
                          controller: toController,
                          decoration: inputField('Ke', Icons.navigation),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Tanggal Perjalanan with Hari Ini and Besok buttons
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.black87),
                        SizedBox(width: 10),
                        Text(
                          'Tanggal Perjalanan',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        Spacer(),
                        // Tombol Hari Ini
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDate = 'Hari Ini';
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: selectedDate == 'Hari Ini'
                                  ? Color(0xff2B7BFF)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Hari Ini',
                              style: TextStyle(
                                color: selectedDate == 'Hari Ini'
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        // Tombol Besok
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDate = 'Besok';
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: selectedDate == 'Besok'
                                  ? Color(0xff2B7BFF)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Besok',
                              style: TextStyle(
                                color: selectedDate == 'Besok'
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Tombol Cari Bus
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PencarianBusPage(
                              Dari: fromController.text,
                              Ke: toController.text,
                              to: '',
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.search),
                      label: Text('Cari Bus'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

InputDecoration inputField(String hint, IconData icon) {
  return InputDecoration(
    hintText: hint,
    prefixIcon: Icon(icon),
    border: InputBorder.none,
    contentPadding: EdgeInsets.symmetric(vertical: 16),
  );
}
