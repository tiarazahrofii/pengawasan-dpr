// lib/admin_page.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/agenda.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Agenda> _list = [];
  final _prefsKey = 'agendas';

  @override
  void initState() {
    super.initState();
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_prefsKey);
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final decoded = jsonDecode(jsonString) as List<dynamic>;
        _list = decoded.map((e) => Agenda.fromJson(Map<String, dynamic>.from(e))).toList();
      } catch (_) {
        _list = [];
      }
    } else {
      _list = [];
    }
    setState(() {});
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_list.map((a) => a.toJson()).toList());
    await prefs.setString(_prefsKey, encoded);
  }

  void _showAddDialog() {
    final t1 = TextEditingController();
    final t2 = TextEditingController();
    final t3 = TextEditingController();
    final t4 = TextEditingController();
    final t5 = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tambah Agenda'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: t1, decoration: const InputDecoration(labelText: 'Judul')),
              TextField(controller: t2, decoration: const InputDecoration(labelText: 'Deskripsi')),
              TextField(controller: t3, decoration: const InputDecoration(labelText: 'Tanggal')),
              TextField(controller: t4, decoration: const InputDecoration(labelText: 'Lokasi (opsional)')),
              TextField(controller: t5, decoration: const InputDecoration(labelText: 'Link (opsional)')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () async {
              final newAgenda = Agenda(
                judul: t1.text.trim(),
                deskripsi: t2.text.trim(),
                tanggal: t3.text.trim(),
                lokasi: t4.text.trim(),
                link: t5.text.trim(),
              );
              setState(() => _list.add(newAgenda));
              await _saveToPrefs();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF800000)),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _editDialog(int index) {
    final a = _list[index];
    final t1 = TextEditingController(text: a.judul);
    final t2 = TextEditingController(text: a.deskripsi);
    final t3 = TextEditingController(text: a.tanggal);
    final t4 = TextEditingController(text: a.lokasi);
    final t5 = TextEditingController(text: a.link);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Agenda'),
        content: SingleChildScrollView(
          child: Column(children: [
            TextField(controller: t1, decoration: const InputDecoration(labelText: 'Judul')),
            TextField(controller: t2, decoration: const InputDecoration(labelText: 'Deskripsi')),
            TextField(controller: t3, decoration: const InputDecoration(labelText: 'Tanggal')),
            TextField(controller: t4, decoration: const InputDecoration(labelText: 'Lokasi (opsional)')),
            TextField(controller: t5, decoration: const InputDecoration(labelText: 'Link (opsional)')),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                _list[index] = Agenda(
                  judul: t1.text.trim(),
                  deskripsi: t2.text.trim(),
                  tanggal: t3.text.trim(),
                  lokasi: t4.text.trim(),
                  link: t5.text.trim(),
                );
              });
              await _saveToPrefs();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF800000)),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Future<void> _delete(int index) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus agenda?'),
        content: const Text('Yakin ingin menghapus agenda ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Hapus')),
        ],
      ),
    );
    if (ok == true) {
      setState(() => _list.removeAt(index));
      await _saveToPrefs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel Admin - DPR'),
        backgroundColor: const Color(0xFF800000),
      ),
      body: _list.isEmpty
          ? Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text('Belum ada agenda.'),
                const SizedBox(height: 12),
                ElevatedButton(onPressed: _showAddDialog, child: const Text('Tambah Agenda')),
              ]),
            )
          : ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, i) {
                final a = _list[i];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: ListTile(
                    title: Text(a.judul),
                    subtitle: Text('${a.tanggal} • ${a.lokasi}\n${a.deskripsi}', maxLines: 3, overflow: TextOverflow.ellipsis),
                    isThreeLine: true,
                    trailing: PopupMenuButton<String>(
                      onSelected: (v) {
                        if (v == 'edit') _editDialog(i);
                        if (v == 'hapus') _delete(i);
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(value: 'edit', child: Text('Edit')),
                        PopupMenuItem(value: 'hapus', child: Text('Hapus')),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        backgroundColor: const Color(0xFF800000),
        child: const Icon(Icons.add),
      ),
    );
  }
}
