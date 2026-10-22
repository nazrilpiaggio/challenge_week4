import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Deklarasi controller dan key untuk form
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D05FA), Color(0xFF2980B9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ), // LinearGradient
        ), // BoxDecoration
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/register.png',
                    height: 350,
                    fit: BoxFit.contain,
                  ), // Image.asset
                  const SizedBox(height: 30),

                  const Text(
                    "Create Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ), // TextStyle
                  ), // Text
                  const SizedBox(height: 10),
                  const Text(
                    "Isi data berikut untuk membuat akun baru",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ), // Text
                  const SizedBox(height: 40),

                  // FORM REGISTER
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ), // RoundedRectangleBorder
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // NAMA FIELD
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Nama Lengkap',
                                prefixIcon: Icon(Icons.person_outline),
                                border: OutlineInputBorder(),
                              ), // InputDecoration
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama tidak boleh kosong';
                                }
                                return null;
                              },
                            ), // TextFormField
                            const SizedBox(height: 20),

                            // EMAIL FIELD
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'contoh: namakamu@email.com',
                                prefixIcon: Icon(Icons.email_outlined),
                                border: OutlineInputBorder(),
                              ), // InputDecoration
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }
                                final emailPattern = RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+$',
                                ); // RegExp
                                if (!emailPattern.hasMatch(value)) {
                                  return 'Format email tidak valid';
                                }
                                return null;
                              },
                            ), // TextFormField
                            const SizedBox(height: 20),

                            // PHONE FIELD
                            TextFormField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Nomor HP',
                                hintText: 'contoh: 081234567890',
                                prefixIcon: Icon(Icons.phone_android),
                                border: OutlineInputBorder(),
                              ), // InputDecoration
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nomor HP tidak boleh kosong';
                                }
                                final numericPattern = RegExp(r'^[0-9]+$');
                                if (!numericPattern.hasMatch(value)) {
                                  return 'Nomor HP hanya boleh berisi angka';
                                }
                                if (value.length < 10) {
                                  return 'Nomor HP minimal 10 digit';
                                }
                                return null;
                              },
                            ), // TextFormField
                            const SizedBox(height: 20),

                            // PASSWORD FIELD
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock_outline),
                                border: OutlineInputBorder(),
                              ), // InputDecoration
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                if (value.length < 6) {
                                  return 'Password minimal 6 karakter';
                                }
                                return null;
                              },
                            ), // TextFormField
                            const SizedBox(height: 20),

                            // CONFIRM PASSWORD FIELD
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Konfirmasi Password',
                                prefixIcon: Icon(Icons.lock_reset),
                                border: OutlineInputBorder(),
                              ), // InputDecoration
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Konfirmasi password tidak boleh kosong';
                                }
                                if (value != _passwordController.text) {
                                  return 'Password tidak sama';
                                }
                                return null;
                              },
                            ), // TextFormField
                            const SizedBox(height: 30),

                            // REGISTER BUTTON
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2980B9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ), // RoundedRectangleBorder
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Registrasi berhasil divalidasi!',
                                        ), // Text
                                      ), // SnackBar
                                    );
                                  }
                                },
                                child: const Text(
                                  'Daftar',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ), // TextStyle
                                ), // Text
                              ), // ElevatedButton
                            ), // SizedBox
                            const SizedBox(height: 16),

                            // LINK LOGIN
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Sudah punya akun? Masuk di sini',
                                style: TextStyle(color: Colors.blueAccent),
                              ), // Text
                            ), // TextButton
                          ], // Column
                        ), // Form
                      ), // Padding
                    ), // Card
                  ),
                ], // Column
              ), // SingleChildScrollView
            ), // Center
          ), // SafeArea
        ), // Container
      ), // Scaffold
    );
  }
}