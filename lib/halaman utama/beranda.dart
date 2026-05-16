import 'package:flutter/material.dart';
import 'package:implementasi_busgo/halaman%20utama/bantuan.dart';
import 'package:implementasi_busgo/halaman%20utama/profil.dart';
import 'package:implementasi_busgo/halaman%20utama/tiket.dart';
import 'package:implementasi_busgo/pemesanan/pemilihan%20kursi.dart';
import 'package:implementasi_busgo/pemesanan/data%20kosong.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> jadwalBus = [
    {
      'rute': 'Jakarta ➔ Solo',
      'waktu': '30 min',
      'tujuan': 'Terminal Tirtonadi'
    },
    {
      'rute': 'Bandung ➔ Semarang',
      'waktu': '45 min',
      'tujuan': 'Terminal Terboyo'
    },
    {
      'rute': 'Surabaya ➔ Bali',
      'waktu': '60 min',
      'tujuan': 'Terminal Ubung'
    },
  ];

  List<Map<String, dynamic>> displayedJadwal = [];

  @override
  void initState() {
    super.initState();
    displayedJadwal = jadwalBus;
  }

  void _filterSearch(String query) {
    setState(() {
      displayedJadwal = jadwalBus
          .where((bus) => bus['rute']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void onNavTap(int index) {
    if (index == 0) return; 
    
    Widget page;
    if (index == 1) {
      page = TiketPage();
    } else if (index == 2) {
      page = BantuanPage(); 
    } else {
      page = ProfilPage(); 
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B2E4B),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onNavTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1B2E4B),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_num_outlined), label: 'Tiket'),
          BottomNavigationBarItem(icon: Icon(Icons.help_outline), label: 'Bantuan'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0, left: 0, right: 0,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Center(
                child: TextField(
                  controller: searchController,
                  onChanged: _filterSearch,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Cari Rute...",
                    hintStyle: const TextStyle(color: Colors.white60),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: 0, right: 0, bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 15),
                      width: 50, height: 5,
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(25, 20, 25, 10),
                    child: Text("Tiket Pilihan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: displayedJadwal.isEmpty 
                    ? DataKosong() 
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: displayedJadwal.length,
                        itemBuilder: (context, index) => _buildTicketCard(displayedJadwal[index]),
                      ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketCard(Map<String, dynamic> bus) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        border: Border.all(color: Colors.grey.shade200)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(bus['waktu'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Icon(Icons.ac_unit, size: 20, color: Colors.blueGrey),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(bus['rute'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(bus['tujuan'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SeatSelectionPage())),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B2E4B)),
                child: const Text("BUY", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ],
      ),
    );
  }
}