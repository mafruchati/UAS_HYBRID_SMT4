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
  // Status kursi: 0=available, 1=booked, 2=your seat
  // Representasi kursi sesuai posisi pada gambar
  final List<List<int>> seats = [
    [1, 0, 0, 0], // Row 1 (A,B,C,D)
    [0, 0, 0, 1],
    [0, 0, 2, 2],
    [1, 1, 0, 0],
    [0, 0, 0, 1],
  ];

  final List<String> columns = ['A', 'B', 'C', 'D'];

  // Untuk toggle Lower/Upper deck
  bool isLowerDeck = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Container(
            color: Color.fromRGBO(
              13,
              110,
              253,
              1,
            ), // warna biru background utama
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header dengan tombol back, title dan next
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Pilih Kursi',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                // Rute perjalanan
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Bawen',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.sync_alt, color: Colors.white, size: 24),
                      SizedBox(width: 5),
                      Text(
                        'Bekasi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Tanggal dan hari
                Center(
                  child: Text(
                    '12 - Januari - 2025 | Minggu',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),

                SizedBox(height: 20),

                // Placeholder box
                Center(
                  child: Container(
                    width: 200,
                    height: 50,
                    color: Colors.grey[300],
                  ),
                ),

                SizedBox(height: 15),

                // Keterangan color box
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _legendBox(Colors.red[300]!, 'Booked'),
                      _legendBox(Colors.grey[300]!, 'Available'),
                      _legendBox(Colors.orange, 'Your Seat', isCircle: true),
                    ],
                  ),
                ),

                SizedBox(height: 15),

                // Row kolom kursi (A B C D)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: columns
                        .map(
                          (col) => Text(
                            col,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),

                SizedBox(height: 4),

                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Kursi kiri (2 kolom)
                        _seatColumn(0),
                        SizedBox(width: 20),

                        // Lower Deck text vertikal
                        RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            isLowerDeck ? 'LOWER DECK' : 'UPPER DECK',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),

                        // Kursi kanan (2 kolom)
                        _seatColumn(2),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Toggle Lower/Upper
                Center(
                  child: Container(
                    width: 200,
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isLowerDeck = true;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isLowerDeck
                                    ? Colors.red[100]
                                    : Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'LOWER',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(width: 2, color: Colors.grey[400]),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isLowerDeck = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: !isLowerDeck
                                    ? Colors.white
                                    : Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'UPPER',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _legendBox(Color color, String label, {bool isCircle = false}) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          ),
        ),
        SizedBox(width: 6),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }

  // Membuat kolom kursi, param colIndex adalah index kolom pertama di kelompok dua kursi (kiri:0, kanan:2)
  Widget _seatColumn(int colIndex) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        seats.length,
        (row) => Row(
          children: [
            _seatBox(seats[row][colIndex]),
            SizedBox(width: 12),
            _seatBox(seats[row][colIndex + 1]),
          ],
        ),
      ),
    );
  }

  // Widget kursi/color box
  Widget _seatBox(int status) {
    Color color;
    Widget? child;

    switch (status) {
      case 0:
        color = Colors.grey[300]!;
        break;
      case 1:
        color = Colors.red[300]!;
        break;
      case 2:
        color = Colors.orange;
        // Membuat tanda bulat di kursi "Your Seat"
        child = Center(
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: Colors.purpleAccent,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        );
        break;
      default:
        color = Colors.grey[300]!;
    }

    return Container(
      width: 36,
      height: 36,
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
