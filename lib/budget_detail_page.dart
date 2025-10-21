import 'package:flutter/material.dart';

// Definisi Warna
const Color primaryRed = Color(0xFFE53935);
const Color darkText = Color(0xFF212121);
const Color lightBackground = Color(0xFFFAFAFA);

class BudgetDetailPage extends StatelessWidget {
  const BudgetDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data Rincian Anggaran (dummy, bisa diganti dari API / shared preferences)
    final List<Map<String, dynamic>> rabData = [
      {
        'kategori': 'Operasional Paripurna',
        'kode': '01.01.A',
        'deskripsi': 'Penyelenggaraan 4x Sidang Paripurna di Gedung Utama.',
        'anggaran_target': 150000000,
        'realisasi': 120000000,
        'bulan_terkait': 'Oktober, November',
      },
      {
        'kategori': 'Kunjungan Kerja',
        'kode': '02.03.B',
        'deskripsi': 'Akomodasi dan transportasi kunjungan ke beberapa provinsi.',
        'anggaran_target': 400000000,
        'realisasi': 250000000,
        'bulan_terkait': 'Oktober',
      },
      {
        'kategori': 'Sosialisasi UU',
        'kode': '03.05.C',
        'deskripsi': 'FGD dan penyebaran materi UU Cipta Kerja.',
        'anggaran_target': 100000000,
        'realisasi': 75000000,
        'bulan_terkait': 'November, Desember',
      },
      {
        'kategori': 'Maintenance Gedung',
        'kode': '04.01.A',
        'deskripsi': 'Perawatan rutin Gedung DPR.',
        'anggaran_target': 200000000,
        'realisasi': 0,
        'bulan_terkait': 'Desember',
      },
    ];

    String formatCurrency(int amount) {
      String str = amount.toString();
      String result = '';
      int count = 0;
      for (int i = str.length - 1; i >= 0; i--) {
        result = str[i] + result;
        count++;
        if (count % 3 == 0 && i != 0) {
          result = '.' + result;
        }
      }
      return 'Rp $result';
    }

    int totalTarget = rabData.fold(0, (sum, item) => sum + (item['anggaran_target'] as int));
    int totalRealisasi = rabData.fold(0, (sum, item) => sum + (item['realisasi'] as int));
    int totalSisa = totalTarget - totalRealisasi;

    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        title: const Text('Rincian Anggaran Belanja (RAB)'),
        backgroundColor: primaryRed,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard('Total Anggaran', formatCurrency(totalTarget), Colors.orange, Icons.bar_chart),
            const SizedBox(height: 10),
            _buildSummaryCard('Total Realisasi', formatCurrency(totalRealisasi), Colors.green, Icons.check_circle),
            const SizedBox(height: 10),
            _buildSummaryCard('Sisa Anggaran', formatCurrency(totalSisa), totalSisa > 0 ? Colors.blue : Colors.red, Icons.wallet),
            const SizedBox(height: 30),
            const Text(
              'Detail Rincian Tiap Pos Anggaran',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: darkText),
            ),
            const Divider(color: Colors.grey, thickness: 1, height: 25),
            ...rabData.map((data) => _buildRabItemCard(data, formatCurrency)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: color, size: 35),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkText)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRabItemCard(Map<String, dynamic> data, String Function(int) formatCurrency) {
    final target = data['anggaran_target'] as int;
    final realisasi = data['realisasi'] as int;
    final progress = realisasi / target;
    final sisa = target - realisasi;

    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data['kategori'] as String, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: primaryRed)),
            Text('Kode: ${data['kode']}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const Divider(height: 15, thickness: 0.5),
            Text(data['deskripsi'] as String, style: const TextStyle(fontSize: 14, color: darkText)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Target: ${formatCurrency(target)}', style: const TextStyle(fontSize: 14, color: Colors.black54)),
                Text('Realisasi: ${formatCurrency(realisasi)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            const SizedBox(height: 5),
            Text('Sisa: ${formatCurrency(sisa)}', style: TextStyle(fontSize: 14, color: sisa < 0 ? Colors.red : Colors.blue)),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              color: primaryRed,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 5),
            Text('Bulan Terkait: ${data['bulan_terkait']}', style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
