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
  // Status kursi: 0=available, 1=booked, 2=selected (your choice)
  // Kita buat dua map data untuk Lower dan Upper Deck
  late List<List<int>> lowerSeats;
  late List<List<int>> upperSeats;

  bool isLowerDeck = true;

  @override
  void initState() {
    super.initState();
    // Inisialisasi data dummy
    lowerSeats = [
      [1, 0, 0, 0],
      [0, 0, 0, 1],
      [0, 0, 0, 0],
      [1, 1, 0, 0],
      [0, 0, 0, 1],
    ];
    upperSeats = [
      [0, 0, 0, 0],
      [1, 1, 1, 1],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 1, 0],
    ];
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
      backgroundColor: const Color(0xFF0D6EFD), // Biru Utama
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
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
          // Info Rute
          _buildRouteInfo(),
          
          SizedBox(height: 20),

          // Legend
          _buildLegend(),

          SizedBox(height: 20),

          // Area Bus
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white24),
              ),
              child: Column(
                children: [
                  // Driver/Front Area Indicator
                  _buildDriverArea(),
                  
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _seatColumn(0), // Kolom A & B
                        _buildDeckIndicator(),
                        _seatColumn(2), // Kolom C & D
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Toggle Lower/Upper
          _buildDeckToggle(),
          SizedBox(height: 30),
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
        _legendItem(Colors.orange, 'Your Seat', isCircle: true),
      ],
    );
  }

  Widget _legendItem(Color color, String label, {bool isCircle = false}) {
    return Row(
      children: [
        Container(
          width: 16, height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircle ? null : BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 5),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildDriverArea() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Icon(Icons.settings_input_component_rounded, color: Colors.white30, size: 40), // Icon Setir
    );
  }

  Widget _buildDeckIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: RotatedBox(
        quarterTurns: 3,
        child: Text(
          isLowerDeck ? 'LOWER DECK' : 'UPPER DECK',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
      ),
    );
  }

  Widget _buildDeckToggle() {
    return Container(
      width: 220,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          _toggleButton('LOWER', isLowerDeck, () => setState(() => isLowerDeck = true)),
          _toggleButton('UPPER', !isLowerDeck, () => setState(() => isLowerDeck = false)),
        ],
      ),
    );
  }

  Widget _toggleButton(String label, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (row) {
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
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: status == 0 ? Colors.white : (status == 1 ? Colors.red[300] : Colors.orange),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            if (status == 2) BoxShadow(color: Colors.orange.withOpacity(0.5), blurRadius: 8)
          ],
        ),
        child: status == 2 
          ? Icon(Icons.check, color: Colors.white, size: 20) 
          : (status == 1 ? Icon(Icons.close, color: Colors.white, size: 20) : null),
      ),
    );
  }
}