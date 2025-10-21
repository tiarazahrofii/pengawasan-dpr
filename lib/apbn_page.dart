// lib/apbn_page.dart
import 'package:flutter/material.dart';
import 'models/apbn.dart';

class ApbnPage extends StatelessWidget {
  final List<APBN> dataApbn;
  final bool isEditable;

  const ApbnPage({
    super.key,
    required this.dataApbn,
    this.isEditable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan APBN"),
        backgroundColor: const Color(0xFFE53935),
      ),
      body: ListView.builder(
        itemCount: dataApbn.length,
        itemBuilder: (context, index) {
          final apbn = dataApbn[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(apbn.bulan),
              subtitle: Text(
                "Total: Rp${apbn.totalAnggaran}\n"
                "Pengeluaran: Rp${apbn.pengeluaran}\n"
                "Sisa: Rp${apbn.sisaAnggaran}",
              ),
              trailing: isEditable
                  ? IconButton(
                      icon: const Icon(Icons.edit, color: Colors.red),
                      onPressed: () {
                        // buka dialog edit di sini
                      },
                    )
                  : null,
            ),
          );
        },
      ),
      floatingActionButton: isEditable
          ? FloatingActionButton(
              onPressed: () {
                // fungsi tambah data APBN
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
