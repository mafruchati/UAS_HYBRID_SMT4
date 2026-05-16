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

  // 1. Update data jadwal dengan tambahan Jam dan Harga
  final List<Map<String, dynamic>> jadwalBus = [
    {
      'asal': 'Jakarta',
      'tujuan_kota': 'Solo',
      'waktu_tunggu': '30',
      'durasi': '15 min',
      'jam_berangkat': '14:00',
      'jam_tiba': '14:50',
      'terminal': 'Terminal Tirtonadi',
      'harga': 'Rp 150.000',
      'tanggal': '25 Mar, 12:30 PM'
    },
    {
      'asal': 'Bandung',
      'tujuan_kota': 'Semarang',
      'waktu_tunggu': '45',
      'durasi': '20 min',
      'jam_berangkat': '15:00',
      'jam_tiba': '15:20',
      'terminal': 'Terminal Terboyo',
      'harga': 'Rp 185.000',
      'tanggal': '25 Mar, 13:00 PM'
    },
    {
      'asal': 'Surabaya',
      'tujuan_kota': 'Bali',
      'waktu_tunggu': '60',
      'durasi': '45 min',
      'jam_berangkat': '16:00',
      'jam_tiba': '16:45',
      'terminal': 'Terminal Mengwi',
      'harga': 'Rp 250.000',
      'tanggal': '25 Mar, 14:15 PM'
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
          .where((bus) => 
              bus['asal']!.toLowerCase().contains(query.toLowerCase()) ||
              bus['tujuan_kota']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void onNavTap(int index) {
    if (index == 0) return; 
    
    Widget page;
    if (index == 1) {
      page = const TiketPage();
    } else if (index == 2) {
      page = const BantuanPage(); 
    } else {
      page = const ProfilPage(); 
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
                color: Color(0xFFF8F9FB), // Background kartu sedikit abu biar kontras
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
                    ? const DataKosong() 
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

  // 2. MODIFIKASI UTAMA: Desain kartu mirip BlueBus
  Widget _buildTicketCard(Map<String, dynamic> bus) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
        border: Border.all(color: Colors.grey.shade200)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BARIS ATAS: DEPARTURE & TRAVEL TIME
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("DEPARTURE ON", style: TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(bus['waktu_tunggu'], style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      const Text(" min", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("TRAVEL TIME  ${bus['durasi']}", style: const TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.access_time_filled, size: 14, color: Colors.black54),
                      const SizedBox(width: 4),
                      Text(bus['jam_berangkat'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      const Icon(Icons.access_time_filled, size: 14, color: Colors.black54),
                      const SizedBox(width: 4),
                      Text(bus['jam_tiba'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.air_rounded, color: Color(0xFF1B2E4B), size: 24),
            ],
          ),
          
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Divider(height: 1, thickness: 0.5),
          ),

          // BARIS TENGAH: RUTE DENGAN TITIK (ORANGE & BLUE)
          Row(
            children: [
              Column(
                children: [
                  const Icon(Icons.circle, size: 10, color: Colors.orange),
                  Container(width: 1.5, height: 25, color: Colors.grey[200]),
                  const Icon(Icons.circle, size: 10, color: Colors.blue),
                ],
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${bus['asal']}  →  ${bus['tujuan_kota']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    const Text("From", style: TextStyle(fontSize: 10, color: Colors.grey)),
                    Text(bus['terminal'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
                    Text(bus['tanggal'], style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // BARIS BAWAH: HARGA & TOMBOL BUY TICKET
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(bus['harga'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B2E4B))),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SeatSelectionPage())),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B2E4B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  elevation: 0,
                ),
                child: const Row(
                  children: [
                    Icon(Icons.confirmation_num_outlined, size: 16, color: Colors.white),
                    SizedBox(width: 8),
                    Text("BUY TICKET", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}