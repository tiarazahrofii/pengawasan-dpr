import 'package:flutter/material.dart';
import 'models/agenda.dart';

class DetailPage extends StatelessWidget {
  final Agenda agenda;

  const DetailPage({super.key, required this.agenda});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Agenda Rapat'),
        backgroundColor: const Color(0xFF800000),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  agenda.judul,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF800000),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Tanggal: ${agenda.tanggal}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const Divider(height: 30, thickness: 1.5),
                Text(
                  agenda.deskripsi,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Dokumentasi dan Hasil Rapat:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Belum ada hasil rapat yang diunggah.",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
