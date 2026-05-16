import 'package:flutter/material.dart';

// --- 1. MODEL DATA ---
// Ini satu-satunya tempat buat nentuin data bus kamu
class Tiket {
  String id;
  String rute;
  String jam;
  String tanggal;
  int harga;

  Tiket({
    required this.id, 
    required this.rute, 
    required this.jam, 
    required this.tanggal, 
    required this.harga
  });
}

void main() => runApp(MaterialApp(
  home: LoginPage(),
  debugShowCheckedModeBanner: false,
));

// --- 2. HALAMAN LOGIN ---
class LoginPage extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("LOGIN BUSGO", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextField(controller: userController, decoration: InputDecoration(labelText: "Username", border: OutlineInputBorder())),
              SizedBox(height: 15),
              TextField(controller: passController, decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder()), obscureText: true),
              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanUtamaTiket())),
                  child: Text("MASUK"),
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 15)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// --- 3. HALAMAN UTAMA (SEARCH & TABEL CRUD) ---
class HalamanUtamaTiket extends StatefulWidget {
  @override
  _HalamanUtamaTiketState createState() => _HalamanUtamaTiketState();
}

class _HalamanUtamaTiketState extends State<HalamanUtamaTiket> {
  // Data Bus Tunggal yang sudah ditentukan rute & harganya
  List<Tiket> dataTiket = [
    Tiket(id: "1", rute: "Semarang - Jakarta", jam: "08:00", tanggal: "2026-05-20", harga: 250000),
    Tiket(id: "2", rute: "Semarang - Surabaya", jam: "19:00", tanggal: "2026-05-21", harga: 300000),
    Tiket(id: "3", rute: "Semarang - Jogja", jam: "10:00", tanggal: "2026-05-22", harga: 150000),
  ];

  List<Tiket> hasilFilter = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    hasilFilter = dataTiket; // Tampilan awal semua data muncul
    super.initState();
  }

  // FITUR SEARCHING
  void filterData(String query) {
    setState(() {
      hasilFilter = dataTiket
          .where((t) => t.rute.toLowerCase().contains(query.toLowerCase()) || 
                        t.tanggal.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pemesanan Tiket Bus")),
      body: Column(
        children: [
          // Navigasi Searching (Ketik rute atau tanggal)
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: searchController,
              onChanged: filterData,
              decoration: InputDecoration(
                hintText: "Cari rute atau tanggal...",
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(icon: Icon(Icons.clear), onPressed: () {
                  searchController.clear();
                  filterData('');
                }),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          
          // Tabel CRUD
          Expanded(
            child: hasilFilter.isEmpty 
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 60, color: Colors.grey),
                    Text("Maaf, rute/jadwal tidak ditemukan", style: TextStyle(color: Colors.grey)),
                  ],
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Rute')),
                      DataColumn(label: Text('Jam')),
                      DataColumn(label: Text('Tanggal')),
                      DataColumn(label: Text('Harga')),
                      DataColumn(label: Text('Aksi')),
                    ],
                    rows: hasilFilter.map((t) => DataRow(cells: [
                      DataCell(Text(t.rute)),
                      DataCell(Text(t.jam)),
                      DataCell(Text(t.tanggal)),
                      DataCell(Text("Rp ${t.harga}")),
                      DataCell(Row(
                        children: [
                          IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: () {
                            // Fungsi Update/Edit
                          }),
                          IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () {
                            // Fungsi Delete
                            setState(() {
                              dataTiket.removeWhere((item) => item.id == t.id);
                              filterData(searchController.text);
                            });
                          }),
                        ],
                      )),
                    ])).toList(),
                  ),
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Fungsi Create / Tambah Tiket Baru
        },
        child: Icon(Icons.add),
        tooltip: "Tambah Pesanan",
      ),
    );
  }
}