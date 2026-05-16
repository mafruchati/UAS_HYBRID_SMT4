import 'package:flutter/material.dart';

class SeatSelectionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tempat Duduk',
      home: SeatSelectionPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SeatSelectionPage extends StatefulWidget {
  @override
  _SeatSelectionPageState createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  late List<List<int>> lowerSeats;
  late List<List<int>> upperSeats;
  bool isLowerDeck = true;

  @override
  void initState() {
    super.initState();
    // Inisialisasi data dummy (5 baris, 4 kolom)
    lowerSeats = List.generate(5, (_) => [1, 0, 0, 0]);
    upperSeats = List.generate(5, (_) => [0, 0, 0, 1]);
    
    // Memberikan variasi data sedikit
    lowerSeats[1] = [0, 0, 0, 1];
    lowerSeats[3] = [1, 1, 0, 0];
  }

  void _handleSeatTap(int row, int col) {
    setState(() {
      List<List<int>> currentSeats = isLowerDeck ? lowerSeats : upperSeats;
      if (currentSeats[row][col] == 0) {
        currentSeats[row][col] = 2; // Pilih
      } else if (currentSeats[row][col] == 2) {
        currentSeats[row][col] = 0; // Batal pilih
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 65, 158),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Pilih Kursi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Next', style: TextStyle(color: Colors.white, fontSize: 16)),
          )
        ],
      ),
      body: Column(
        children: [
          _buildRouteInfo(),
          SizedBox(height: 20),
          _buildLegend(),
          SizedBox(height: 20),

          // Area Bus dengan Scroll agar tidak overflow
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                border: Border.all(color: Colors.white24),
              ),
              child: SingleChildScrollView( // <--- Solusi Overflow
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildDriverArea(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _seatColumn(0), // Kolom kiri (A & B)
                        _buildDeckIndicator(),
                        _seatColumn(2), // Kolom kanan (C & D)
                      ],
                    ),
                    SizedBox(height: 40), // Ruang tambahan di bawah scroll
                  ],
                ),
              ),
            ),
          ),

          // Bagian Toggle tetap di bawah (Fixed)
          Container(
            padding: EdgeInsets.only(top: 15, bottom: 30),
            color: Color.fromARGB(255, 5, 62, 148),
            child: _buildDeckToggle(),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteInfo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bawen', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.sync_alt, color: Colors.white),
            ),
            Text('Bekasi', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
        Text('12 - Januari - 2025 | Minggu', style: TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(Colors.red[300]!, 'Booked'),
        SizedBox(width: 15),
        _legendItem(Colors.white, 'Available'),
        SizedBox(width: 15),
        _legendItem(Colors.orange, 'Your Seat'),
      ],
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 14, height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 6),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildDriverArea() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Icon(Icons.settings_input_component_rounded, color: Colors.white30, size: 40),
          SizedBox(height: 10),
          Container(width: 60, height: 2, color: Colors.white12),
        ],
      ),
    );
  }

  Widget _buildDeckIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: RotatedBox(
        quarterTurns: 3,
        child: Text(
          isLowerDeck ? 'LOWER DECK' : 'UPPER DECK',
          style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildDeckToggle() {
    return Center(
      child: Container(
        width: 220,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            _toggleButton('LOWER', isLowerDeck, () => setState(() => isLowerDeck = true)),
            _toggleButton('UPPER', !isLowerDeck, () => setState(() => isLowerDeck = false)),
          ],
        ),
      ),
    );
  }

  Widget _toggleButton(String label, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.all(4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: active ? Color(0xFF0D6EFD) : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _seatColumn(int colStart) {
    List<List<int>> currentSeats = isLowerDeck ? lowerSeats : upperSeats;
    return Column(
      children: List.generate(currentSeats.length, (row) {
        return Row(
          children: [
            _seatBox(row, colStart, currentSeats[row][colStart]),
            SizedBox(width: 10),
            _seatBox(row, colStart + 1, currentSeats[row][colStart + 1]),
          ],
        );
      }),
    );
  }

  Widget _seatBox(int row, int col, int status) {
    return GestureDetector(
      onTap: () => _handleSeatTap(row, col),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 45,
        height: 45,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: status == 0 ? Colors.white : (status == 1 ? Colors.red[300] : Colors.orange),
          borderRadius: BorderRadius.circular(12),
        ),
        child: status == 2 
          ? Icon(Icons.check, color: Colors.white, size: 22) 
          : (status == 1 ? Icon(Icons.close, color: Colors.white, size: 22) : null),
      ),
    );
  }
}