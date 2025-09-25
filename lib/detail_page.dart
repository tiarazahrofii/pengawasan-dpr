import 'package:flutter/material.dart';
import 'models/agenda.dart';

class DetailPage extends StatelessWidget {
  final Agenda agenda;

  const DetailPage({super.key, required this.agenda});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text(agenda.judul),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          agenda.detail,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
