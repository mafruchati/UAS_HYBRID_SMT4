import 'package:flutter/material.dart';
import 'package:implementasi_busgo/halaman%20utama/beranda.dart';
import 'package:implementasi_busgo/halaman_login/halaman%20sig%20in.dart';




class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(13, 110, 253, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),

            // Logo BusGo
            Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.directions_bus,
                    color: const Color.fromRGBO(13, 110, 253, 1),
                    size: 70,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'BusGo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60),

            // Card Putih
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 50,
                  horizontal: 30,
                ),
                child: Column(
                  children: [
                    // Username input
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: "Username",
                        filled: true,
                        fillColor: const Color.fromARGB(255, 209, 216, 226),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Password input
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        filled: true,
                        fillColor: const Color.fromARGB(255, 209, 216, 226),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Tombol Login
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          // Cek sederhana
                          if (usernameController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Username dan password wajib diisi")),
                            );
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Garis OR
                    const Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "or Login with",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey)),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // Ikon Sosial Media
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialIcon(Icons.g_mobiledata, onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Login dengan Google ditekan")),
                          );
                        }),
                        const SizedBox(width: 20),

                        _socialIcon(Icons.telegram, onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Login dengan Telegram")),
                          );
                        }),
                        const SizedBox(width: 20),

                        _socialIcon(Icons.facebook, onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Login dengan Facebook")),
                          );
                        }),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Sign up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpPage()),
                            );
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              color: Color(0xFF0D6EFD),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _socialIcon(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 32),
      ),
    );
  }
}
