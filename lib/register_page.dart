import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Registrasi'),
        backgroundColor: Color(0xFFE53935),
      ),
      body: const Center(
        child: Text(
          'Form registrasi masih dalam pengembangan.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
