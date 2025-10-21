import 'package:flutter/material.dart';
import 'home_page.dart';
import 'apbn_page.dart';
import 'laporan_bulanan_page.dart';
import 'laporan_tahunan_page.dart';
import 'login_page.dart';
import 'models/apbn.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String username;

  const CustomAppBar({super.key, required this.title, required this.username});

  // contoh data dummy APBN
  List<APBN> _sampleApbnData() {
    return [
      APBN(bulan: 'Januari', totalAnggaran: 100000000, pengeluaran: 70000000),
      APBN(bulan: 'Februari', totalAnggaran: 100000000, pengeluaran: 85000000),
      APBN(bulan: 'Maret', totalAnggaran: 100000000, pengeluaran: 92000000),
      APBN(bulan: 'April', totalAnggaran: 100000000, pengeluaran: 50000000),
      APBN(bulan: 'Mei', totalAnggaran: 100000000, pengeluaran: 40000000),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: const Color(0xFFE53935),
      actions: [
        // 🔹 Beranda
        TextButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomePage(username: username),
            ),
          ),
          child: const Text('Beranda', style: TextStyle(color: Colors.white)),
        ),

        // 🔹 Lihat APBN (semua role bisa lihat)
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ApbnPage(
                dataApbn: _sampleApbnData(),
                isEditable: username.toLowerCase() == 'admin', // hanya admin bisa ubah
              ),
            ),
          ),
          child: const Text('Lihat APBN', style: TextStyle(color: Colors.white)),
        ),

        // 🔹 Laporan Bulanan
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LaporanBulananPage(username: username),
            ),
          ),
          child: const Text('Laporan Bulanan', style: TextStyle(color: Colors.white)),
        ),

        // 🔹 Laporan Tahunan
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LaporanTahunanPage(username: username),
            ),
          ),
          child: const Text('Laporan Tahunan', style: TextStyle(color: Colors.white)),
        ),

        // 🔹 Logout
        TextButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          ),
          child: const Text('Logout', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
