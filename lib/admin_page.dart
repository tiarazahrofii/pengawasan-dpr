import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/agenda.dart';

const Color primaryRed = Color(0xFFE53935);
const Color darkText = Color(0xFF212121);
const Color lightBackground = Color(0xFFFAFAFA);

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final String _prefsKey = 'agendas';
  List<Map<String, dynamic>> _agendaDataList = [];

  @override
  void initState() {
    super.initState();
    _loadAgendas();
  }

  Future<void> _loadAgendas() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_prefsKey);
    if (jsonString != null && jsonString.isNotEmpty) {
      final decoded = jsonDecode(jsonString) as List<dynamic>;
      setState(() {
        _agendaDataList = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
      });
    }
  }

  Future<void> _saveAgendas() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, jsonEncode(_agendaDataList));
    setState(() {});
  }

  void _addAgenda() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tambah Agenda Baru'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField(_titleController, 'Judul'),
              const SizedBox(height: 8),
              _buildTextField(_descController, 'Deskripsi'),
              const SizedBox(height: 8),
              _buildTextField(_dateController, 'Tanggal'),
              const SizedBox(height: 8),
              _buildTextField(_locationController, 'Lokasi'),
              const SizedBox(height: 8),
              _buildTextField(_budgetController, 'Anggaran (Rp)', isNumber: true),
              const SizedBox(height: 8),
              _buildTextField(_imageController, 'URL Gambar'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_titleController.text.isEmpty || _descController.text.isEmpty) return;
              _agendaDataList.add({
                'judul': _titleController.text,
                'deskripsi': _descController.text,
                'tanggal': _dateController.text,
                'lokasi': _locationController.text,
                'anggaran': int.tryParse(_budgetController.text) ?? 0,
                'image': _imageController.text.isNotEmpty
                    ? _imageController.text
                    : 'https://picsum.photos/400/200',
                'rating': 5,
              });
              _saveAgendas();
              _clearControllers();
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _clearControllers() {
    _titleController.clear();
    _descController.clear();
    _dateController.clear();
    _locationController.clear();
    _budgetController.clear();
    _imageController.clear();
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  void _deleteAgenda(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Agenda?'),
        content: const Text('Apakah Anda yakin ingin menghapus agenda ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              _agendaDataList.removeAt(index);
              _saveAgendas();
              Navigator.pop(context);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        title: const Text('Admin - Kelola Agenda'),
        backgroundColor: primaryRed,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _agendaDataList.length,
        itemBuilder: (context, index) {
          final agenda = _agendaDataList[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 3,
            child: ListTile(
              leading: Image.network(
                agenda['image'] ?? 'https://picsum.photos/100/60',
                width: 80,
                fit: BoxFit.cover,
              ),
              title: Text(agenda['judul'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(agenda['deskripsi'] ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteAgenda(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAgenda,
        backgroundColor: primaryRed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
