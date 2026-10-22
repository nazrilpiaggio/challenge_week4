import 'package:flutter/material.dart';
import 'register_page.dart';
import 'main_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // _formKey digunakan untuk validasi form.
  // Controller menyimpan input email dan password.
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6D05FA),
              Color(0xFF2980B9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            // SingleChildScrollView agar halaman bisa di-scroll.
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/login.png',
                    height: 350,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Card form login.
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Email Field
                            TextFormField(
                              controller: _emailController,
                              keyboardType:
                                  TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText:
                                    'contoh: Namamu@email.com',
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }

                                final emailPattern = RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+$',
                                );

                                if (!emailPattern.hasMatch(value)) {
                                  return 'Format email tidak valid';
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 20),

                            // Password Field
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                ),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }

                                if (value.length < 6) {
                                  return 'Password minimal 6 karakter';
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 30),

                            // Button Login
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFF2980B9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12),
                                  ),
                                ),
onPressed: () {
                                      // Cek apakah semua inputan (email & password) valid
                                      if (_formKey.currentState!.validate()) {
                                        
                                        // Opsional: Tampilkan SnackBar sukses sebentar
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Login Berhasil!'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );

                                        // Pindah ke MainScreen
                                        Navigator.pushReplacement( // Gunakan pushReplacement agar tidak bisa back ke login
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MainScreen(), 
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'Masuk',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            const SizedBox(height: 16),

                            // Tombol untuk berpindah ke halaman register
                            TextButton(
                              onPressed: () {
                                // Navigasi ke halaman register
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterPage(),
                                  ), // MaterialPageRoute
                                );
                              },
                              child: const Text(
                                'Belum punya akun? Daftar di sini',
                                style: TextStyle(color: Colors.blueAccent),
                              ), // Text
                            ), // TextButton
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}