// lib/laporan_bulanan_page.dart
import 'package:flutter/material.dart';
import 'custom_appbar.dart';

class LaporanBulananPage extends StatelessWidget {
  final String username;
  const LaporanBulananPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Laporan Bulanan', username: username),
      body: const Center(
        child: Text(
          'Halaman Laporan Keuangan Bulanan masih dalam pengembangan',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
