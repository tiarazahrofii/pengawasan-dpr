class Agenda {
  final String judul;
  final String deskripsi;
  final String tanggal;
  final String lokasi;
  final int anggaran;
  final double rating;

  Agenda({
    required this.judul,
    required this.deskripsi,
    required this.tanggal,
    required this.lokasi,
    required this.anggaran,
    required this.rating,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) {
    return Agenda(
      judul: json['judul'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      tanggal: json['tanggal'] ?? '',
      lokasi: json['lokasi'] ?? '',
      anggaran: json['anggaran'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'judul': judul,
      'deskripsi': deskripsi,
      'tanggal': tanggal,
      'lokasi': lokasi,
      'anggaran': anggaran,
      'rating': rating,
    };
  }
}
