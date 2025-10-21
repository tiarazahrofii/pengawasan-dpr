import 'package:flutter/material.dart';

class LaporanKeuanganPage extends StatelessWidget {
  const LaporanKeuanganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Keuangan'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ListTile(
            leading: Icon(Icons.insert_drive_file),
            title: Text('Laporan Keuangan Bulanan'),
            subtitle: Text('Klik untuk melihat laporan bulan ini'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.insert_chart),
            title: Text('Laporan Keuangan Tahunan'),
            subtitle: Text('Klik untuk melihat laporan tahun ini'),
          ),
        ],
      ),
    );
  }
}
