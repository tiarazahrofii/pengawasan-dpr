import 'package:flutter/material.dart';
import 'models/agenda.dart';

class DetailPage extends StatelessWidget {
  final Agenda agenda;
  const DetailPage({super.key, required this.agenda});

  String formatCurrency(int amount) {
    String str = amount.toString();
    String result = '';
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      result = str[i] + result;
      count++;
      if (count % 3 == 0 && i != 0) result = '.' + result;
    }
    return 'Rp $result';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(agenda.judul),
        backgroundColor: const Color(0xFFE53935),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              agenda.judul,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '${agenda.rating}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                Icon(Icons.monetization_on, color: Colors.green),
                const SizedBox(width: 4),
                Text(
                  formatCurrency(agenda.anggaran),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Icon(Icons.calendar_month, color: Colors.grey),
                const SizedBox(width: 5),
                Text(agenda.tanggal),
                const SizedBox(width: 15),
                Icon(Icons.location_on, color: Colors.grey),
                const SizedBox(width: 5),
                Expanded(child: Text(agenda.lokasi)),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              agenda.deskripsi,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
