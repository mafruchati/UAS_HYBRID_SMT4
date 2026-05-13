import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: const Color(0xFF2B7BFF),
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num_outlined),
            label: 'Tiket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Bantuan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            const SizedBox(height: 16),
            _section(
              title: 'Rincian Saya',
              children: [
                _menuItem(Icons.lock_outline, 'Informasi Profil'),
                _menuItem(Icons.receipt_long, 'Pemesanan'),
                _menuItem(Icons.people_outline, 'Penumpang'),
                _menuItem(Icons.notifications_none, 'Notifikasi'),
              ],
            ),
            const SizedBox(height: 16),
            _section(
              title: 'Pembayaran',
              children: [
                _menuItem(Icons.credit_card, 'Metode Pembayaran'),
                _menuItem(Icons.account_balance, 'Rekening Pengembalian dana'),
              ],
            ),
            const SizedBox(height: 16),
            _section(
              title: 'Lainnya',
              children: [
                _menuItem(Icons.help_outline, 'Bantuan'),
                _menuItem(Icons.info_outline, 'Tentang Aplikasi'),
                _menuItem(Icons.logout, 'Keluar'),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 45, 20, 25),
      decoration: const BoxDecoration(
        color: Color(0xFF2B7BFF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.directions_bus,
              color: Color(0xFF2B7BFF),
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                'My Profil',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.search, color: Colors.white, size: 26),
        ],
      ),
    );
  }

  Widget _section({
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2B7BFF),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String text) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(icon, size: 22),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
