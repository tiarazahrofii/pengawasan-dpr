// lib/laporan_tahunan_page.dart
import 'package:flutter/material.dart';
import 'custom_appbar.dart';

class LaporanTahunanPage extends StatelessWidget {
  final String username;
  const LaporanTahunanPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Laporan Tahunan', username: username),
      body: const Center(
        child: Text(
          'Halaman Laporan Keuangan Tahunan masih dalam pengembangan',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
