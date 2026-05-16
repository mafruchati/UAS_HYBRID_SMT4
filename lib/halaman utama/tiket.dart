import 'package:flutter/material.dart';

class TiketPage extends StatefulWidget {
  const TiketPage({super.key});

  @override
  State<TiketPage> createState() => _TiketPageState();
}

class _TiketPageState extends State<TiketPage> {
  // Simulasi data tiket yang sudah dibeli (Jika kosong, tampilkan pesan "Belum ada")
  final List<Map<String, dynamic>> riwayatTiket = [
    {
      'rute': 'Jakarta ➔ Solo',
      'tanggal': '22 March 2026',
      'bus_no': '4378',
      'jam': '11:45',
      'status': 'Aktif'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B2E4B), // Konsisten dengan Beranda
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("YOUR TICKET", style: TextStyle(color: Colors.white, fontSize: 16)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // Bagian Putih (Area Tiket)
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
              ),
              child: riwayatTiket.isEmpty ? _buildEmptyState() : _buildTicketList(),
            ),
          ),
        ],
      ),
    );
  }

  // Tampilan jika TIDAK ADA tiket (Sesuai code lama kamu)
  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.confirmation_num_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            'Belum ada perjalanan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            'Anda belum memiliki pemesanan, pesan perjalanan Anda selanjutnya sekarang!',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B2E4B),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text("Pesan Sekarang", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  // Tampilan jika ADA tiket (Sesuai layar ketiga di edited-image.jpg)
  Widget _buildTicketList() {
    return ListView.builder(
      padding: const EdgeInsets.all(25),
      itemCount: riwayatTiket.length,
      itemBuilder: (context, index) {
        final data = riwayatTiket[index];
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Text(data['rute'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const Divider(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoColumn("Date", data['tanggal']),
                  _infoColumn("Bus No.", data['bus_no']),
                ],
              ),
              const SizedBox(height: 20),
              // Barcode Mockup (Sesuai Gambar)
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Barcode_Standard_Code_39.png/800px-Barcode_Standard_Code_39.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text("12345678901234567", style: TextStyle(letterSpacing: 2, fontSize: 12)),
            ],
          ),
        );
      },
    );
  }

  Widget _infoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}