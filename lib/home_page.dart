import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/agenda.dart';
import 'detail_page.dart';
import 'admin_page.dart';
import 'budget_detail_page.dart';
import 'login_page.dart';
import 'models/apbn.dart';
import 'apbn_page.dart';
import 'laporan_keuangan_page.dart'; // Tambahan untuk laporan keuangan

const Color primaryRed = Color(0xFFE53935);
const Color darkText = Color(0xFF212121);
const Color lightBackground = Color(0xFFFAFAFA);

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _agendaDataList = [];
  final String _prefsKey = 'agendas';

  @override
  void initState() {
    super.initState();
    _loadAgendas();
  }

  List<Agenda> get _agendaList =>
      _agendaDataList.map((m) => Agenda.fromJson(Map<String, dynamic>.from(m))).toList();

  Future<void> _loadAgendas() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_prefsKey);

    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final decoded = jsonDecode(jsonString) as List<dynamic>;
        setState(() {
          _agendaDataList = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
        });
        return;
      } catch (_) {}
    }

    final defaultsData = [
      {
        'judul': 'Rapat Paripurna DPR',
        'deskripsi': 'Pembahasan RUU Perlindungan Data Pribadi',
        'tanggal': '10 Oktober 2025',
        'lokasi': 'Gedung DPR',
        'anggaran': 50000000,
        'rating': 4.5,
      },
      {
        'judul': 'Rapat Komisi III',
        'deskripsi': 'Koordinasi bersama Kemenkumham (Fokus Daerah)',
        'tanggal': '12 Oktober 2025',
        'lokasi': 'Gedung Nusantara',
        'anggaran': 35000000,
        'rating': 4.0,
      },
      {
        'judul': 'Kunjungan Kerja ke Jawa Barat',
        'deskripsi': 'Penyerapan aspirasi publik di Jawa Barat',
        'tanggal': '15 Oktober 2025',
        'lokasi': 'Bandung, Jawa Barat',
        'anggaran': 150000000,
        'rating': 4.8,
      },
      {
        'judul': 'Sidang Pleno Terbuka (APBN)',
        'deskripsi': 'Pengesahan Anggaran Pendapatan Belanja Negara (APBN)',
        'tanggal': '20 November 2025',
        'lokasi': 'Gedung Paripurna',
        'anggaran': 70000000,
        'rating': 4.2,
      },
      {
        'judul': 'Focus Group Discussion (FGD)',
        'deskripsi': 'Sosialisasi UU Cipta Kerja dengan komunitas lokal',
        'tanggal': '05 Desember 2025',
        'lokasi': 'Balai Warga',
        'anggaran': 45000000,
        'rating': 4.1,
      },
      {
        'judul': 'Rapat Komisi I (Kebijakan Nasional)',
        'deskripsi': 'Evaluasi Kebijakan Pertahanan dan Keamanan',
        'tanggal': '10 Desember 2025',
        'lokasi': 'Gedung Komisi I',
        'anggaran': 28000000,
        'rating': 3.9,
      },
    ];

    setState(() => _agendaDataList = defaultsData);
    await prefs.setString(_prefsKey, jsonEncode(_agendaDataList));
  }

  String getRole(String username) {
    switch (username.toLowerCase()) {
      case 'admin':
        return 'Admin';
      case 'walikota':
        return 'Walikota';
      case 'presiden':
        return 'Presiden';
      case 'masyarakat':
        return 'Masyarakat';
      default:
        return 'Tamu';
    }
  }

  void _logout() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  String _formatCurrency(int amount) {
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

  List<Map<String, dynamic>> _getRoleSpecificAgendasData(String role) {
    final filtered = _agendaDataList.where((data) {
      final title = (data['judul'] as String).toLowerCase();
      final location = (data['lokasi'] as String).toLowerCase();

      switch (role) {
        case 'Admin':
          return true;
        case 'Presiden':
          return title.contains('paripurna') ||
              title.contains('pleno') ||
              title.contains('nasional') ||
              title.contains('apbn');
        case 'Walikota':
          return title.contains('komisi') ||
              title.contains('daerah') ||
              location.contains('gedung nusantara');
        case 'Masyarakat':
          return title.contains('kunjungan kerja') ||
              title.contains('sosialisasi') ||
              location.contains('balai warga');
        default:
          return true;
      }
    }).toList();
    return filtered.reversed.toList();
  }

  Widget _buildAgendaCard(Map<String, dynamic> data, BuildContext context) {
    final agenda = Agenda.fromJson(data);
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => DetailPage(agenda: agenda))),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(agenda.judul,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 3),
                Text('${agenda.rating}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                Icon(Icons.monetization_on, color: Colors.green, size: 16),
                const SizedBox(width: 3),
                Text(_formatCurrency(agenda.anggaran),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.calendar_month, color: Colors.grey, size: 16),
                const SizedBox(width: 3),
                Text(agenda.tanggal),
                const SizedBox(width: 15),
                Icon(Icons.location_on, color: Colors.grey, size: 16),
                const SizedBox(width: 3),
                Expanded(child: Text(agenda.lokasi)),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final role = getRole(widget.username);
    final roleSpecificAgendas = _getRoleSpecificAgendasData(role);

    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        backgroundColor: primaryRed,
        automaticallyImplyLeading: false,
        title: Text(
          "Transparansi DPR - $role",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (role == 'Presiden' || role == 'Admin') ...[
            IconButton(
              icon: const Icon(Icons.bar_chart, color: Colors.white),
              tooltip: 'Lihat APBN',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ApbnPage(
                      dataApbn: [
                        APBN(bulan: 'Januari', totalAnggaran: 100000000, pengeluaran: 70000000),
                        APBN(bulan: 'Februari', totalAnggaran: 100000000, pengeluaran: 85000000),
                        APBN(bulan: 'Maret', totalAnggaran: 100000000, pengeluaran: 92000000),
                        APBN(bulan: 'April', totalAnggaran: 100000000, pengeluaran: 50000000),
                        APBN(bulan: 'Mei', totalAnggaran: 100000000, pengeluaran: 40000000),
                      ],
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.description, color: Colors.white),
              tooltip: 'Laporan Keuangan',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LaporanKeuanganPage()),
                );
              },
            ),
          ],
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: roleSpecificAgendas.isEmpty
              ? [
                  const Center(
                    child: Text('Tidak ada agenda relevan',
                        style: TextStyle(fontSize: 16)),
                  ),
                ]
              : roleSpecificAgendas
                  .map((data) => _buildAgendaCard(data, context))
                  .toList(),
        ),
      ),
      floatingActionButton: role == 'Admin'
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AdminPage()),
              ),
              backgroundColor: primaryRed,
              icon: const Icon(Icons.admin_panel_settings),
              label: const Text('Kelola Agenda'),
            )
          : null,
    );
  }
}
