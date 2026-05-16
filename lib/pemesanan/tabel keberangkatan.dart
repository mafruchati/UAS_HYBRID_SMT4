import 'package:flutter/material.dart';
import 'package:implementasi_busgo/pemesanan/pemilihan%20kursi.dart';


class PencarianBusPage extends StatelessWidget {
  const PencarianBusPage({
    super.key,
    required String Dari,
    required String to,
    required String Ke,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(13, 110, 253, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),

              // =====================
              // HEADER (Back + Search Box)
              // =====================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [_searchBox()],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // =====================
              // WHITE CONTAINER
              // =====================
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // BUS CARD 1
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeatSelectionApp(),
                        ),
                      ),
                      child: _busCard(
                        harga: "IDR 350.000",
                        jamBerangkat: "06:00",
                        kotaBerangkat: "Bawen",
                        durasi: "9h",
                        jamTiba: "15.00",
                        kotaTiba: "Bekasi",
                        detail: "Sangitam Travels, A/C Sleeper 2+2",
                      ),
                    ),

                    const SizedBox(height: 20),

                    // BUS CARD 2
                    _busCard(
                      harga: "IDR 350.000",
                      jamBerangkat: "17:00",
                      kotaBerangkat: "Bawen",
                      durasi: "8h 15m",
                      jamTiba: "01.15",
                      kotaTiba: "Bekasi",
                      detail: "Infra Travels, Suite Class 1+1",
                    ),

                    const SizedBox(height: 20),

                    // SECTION INFO
                    Column(
                      children: const [
                        Text(
                          "Dari Bawen to Bekasi",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "13 Bis dari titik jemput dan turun yang lain",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===============================
  // SEARCH BOX (Rute + Tanggal + Kursi)
  // ===============================
  Widget _searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ROW 1 — Rute + tanggal kecil
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Bawen to Bekasi",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              Text(
                "12 Jan\nMinggu",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            "5 Bis",
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ===============================
  // KARTU BUS (Reusable)
  // ===============================
  Widget _busCard({
    required String harga,
    required String jamBerangkat,
    required String kotaBerangkat,
    required String durasi,
    required String jamTiba,
    required String kotaTiba,
    required String detail,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 3),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          // Harga
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                harga,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Waktu & Durasi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Jam berangkat
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jamBerangkat,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    kotaBerangkat,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),

              // Durasi
              Column(
                children: [
                  const Text("———"),
                  Text(
                    durasi,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),

              // Jam tiba
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    jamTiba,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    kotaTiba,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Detail bus
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              detail,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
