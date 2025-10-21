// lib/models/apbn.dart
class APBN {
  final String bulan;
  final int totalAnggaran;
  final int pengeluaran;

  APBN({
    required this.bulan,
    required this.totalAnggaran,
    required this.pengeluaran,
  });

  // getter untuk sisa anggaran
  int get sisaAnggaran => totalAnggaran - pengeluaran;

  factory APBN.fromJson(Map<String, dynamic> json) {
    return APBN(
      bulan: json['bulan'] ?? '',
      totalAnggaran: (json['totalAnggaran'] as num?)?.toInt() ?? 0,
      pengeluaran: (json['pengeluaran'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bulan': bulan,
      'totalAnggaran': totalAnggaran,
      'pengeluaran': pengeluaran,
    };
  }
}
