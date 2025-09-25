import 'package:flutter/material.dart';
import 'models/user.dart';
import 'models/agenda.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  final User user;

  HomePage({super.key, required this.user});

  final Map<String, List<Agenda>> agendaData = {
    "Masyarakat Umum": [
      Agenda(judul: "Sidang Paripurna DPR", detail: "Laporan hasil sidang paripurna terbuka untuk masyarakat."),
      Agenda(judul: "Informasi RUU Baru", detail: "RUU baru yang sedang dibahas DPR."),
    ],
    "Walikota Madiun": [
      Agenda(judul: "Sidang Paripurna DPR", detail: "Catatan internal untuk Walikota mengenai hasil sidang."),
      Agenda(judul: "Evaluasi Kinerja DPR", detail: "Laporan kinerja DPR bulan ini untuk Walikota."),
    ],
    "Presiden": [
      Agenda(judul: "Laporan Kinerja DPR", detail: "Detail laporan resmi DPR kepada Presiden."),
      Agenda(judul: "Undangan Sidang Khusus", detail: "Surat undangan sidang khusus DPR."),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final List<Agenda> agendaList = agendaData[user.role] ?? [];

    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text("Pengawasan DPR"),
        backgroundColor: Colors.pink,
        leading: Image.asset("assets/logo.jpg"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Selamat datang ${user.username},\n(${user.role})",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text("Agenda DPR:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: agendaList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(agendaList[index].judul),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.pink),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPage(agenda: agendaList[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
