// lib/home_page.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/agenda.dart';
import 'detail_page.dart';
import 'admin_page.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Agenda> _agendaList = [];
  final String _prefsKey = 'agendas';

  @override
  void initState() {
    super.initState();
    _loadAgendas();
  }

  Future<void> _loadAgendas() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_prefsKey);
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final decoded = jsonDecode(jsonString) as List<dynamic>;
        setState(() {
          _agendaList = decoded.map((e) => Agenda.fromJson(Map<String, dynamic>.from(e))).toList();
        });
        return;
      } catch (_) {
        // fallthrough to defaults
      }
    }

    // defaults if no saved agendas
    final defaults = [
      Agenda(judul: 'Rapat Paripurna DPR', deskripsi: 'Pembahasan RUU Perlindungan Data Pribadi', tanggal: '10 Oktober 2025', lokasi: 'Gedung DPR'),
      Agenda(judul: 'Rapat Komisi III', deskripsi: 'Koordinasi bersama Kemenkumham', tanggal: '12 Oktober 2025', lokasi: 'Gedung Nusantara'),
    ];
    setState(() => _agendaList = defaults);
    // save defaults so admin can edit later
    await prefs.setString(_prefsKey, jsonEncode(_agendaList.map((a) => a.toJson()).toList()));
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

  Future<void> _openAdmin() async {
    // only admin allowed (HomePage shows button only if admin)
    await Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminPage()));
    // after admin page closed, reload agendas (so changes appear)
    await _loadAgendas();
  }

  @override
  Widget build(BuildContext context) {
    final role = getRole(widget.username);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pengawasan DPR - $role'),
        backgroundColor: const Color(0xFF800000),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Selamat datang, ${widget.username}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF800000))),
          const SizedBox(height: 8),
          const Text('Daftar Agenda DPR:'),
          const SizedBox(height: 10),
          Expanded(
            child: _agendaList.isEmpty
                ? const Center(child: Text('Belum ada agenda'))
                : ListView.builder(
                    itemCount: _agendaList.length,
                    itemBuilder: (ctx, i) {
                      final a = _agendaList[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(a.judul),
                          subtitle: Text('${a.tanggal} • ${a.lokasi}'),
                          onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => DetailPage(agenda: a))),
                        ),
                      );
                    },
                  ),
          ),
        ]),
      ),
      floatingActionButton: getRole(widget.username) == 'Admin'
          ? FloatingActionButton(
              onPressed: _openAdmin,
              backgroundColor: const Color(0xFF800000),
              child: const Icon(Icons.admin_panel_settings),
            )
          : null,
    );
  }
}
