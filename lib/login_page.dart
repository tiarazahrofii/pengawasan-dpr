// lib/login_page.dart
import 'package:flutter/material.dart';
import 'models/user.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscure = true;
  String _error = "";

  // dummy users (sesuai daftar yang kamu request)
  final List<User> users = [
    User(username: "masyarakat", password: "1234", role: "Masyarakat Umum"),
    User(username: "Tiara Zahrofi Ifadhah, S.Kom", password: "1212", role: "Walikota Madiun"),
    User(username: "presiden", password: "9090", role: "Presiden"),
  ];

  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    User? matchedUser;
    for (var u in users) {
      if (u.username == username && u.password == password) {
        matchedUser = u;
        break;
      }
    }

    if (matchedUser != null) {
      // matchedUser sudah dipastikan bukan null → gunakan matchedUser!
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(user: matchedUser!),
        ),
      );
    } else {
      setState(() {
        _error = "❌ Username atau Password salah!";
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFADADD), // soft pink
      appBar: AppBar(
        title: const Text("Login DPR"),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/logo.jpg", height: 90),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  if (_error.isNotEmpty)
                    Text(_error, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Login", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          // contoh isi cepat untuk testing
                          _usernameController.text =
                              "Tiara Zahrofi Ifadhah, S.Kom";
                          _passwordController.text = "1212";
                        },
                        child: const Text("Isi Walikota"),
                      ),
                      TextButton(
                        onPressed: () {
                          _usernameController.text = "masyarakat";
                          _passwordController.text = "1234";
                        },
                        child: const Text("Isi Masyarakat"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
