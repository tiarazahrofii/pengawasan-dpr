// lib/models/agenda.dart
class Agenda {
  String judul;
  String deskripsi;
  String tanggal;
  String lokasi;
  String link;

  Agenda({
    required this.judul,
    required this.deskripsi,
    required this.tanggal,
    this.lokasi = '',
    this.link = '',
  });

  Map<String, dynamic> toJson() => {
        'judul': judul,
        'deskripsi': deskripsi,
        'tanggal': tanggal,
        'lokasi': lokasi,
        'link': link,
      };

  factory Agenda.fromJson(Map<String, dynamic> m) => Agenda(
        judul: m['judul'] ?? '',
        deskripsi: m['deskripsi'] ?? '',
        tanggal: m['tanggal'] ?? '',
        lokasi: m['lokasi'] ?? '',
        link: m['link'] ?? '',
      );

  @override
  String toString() => 'Agenda(judul: $judul, tanggal: $tanggal)';
}
