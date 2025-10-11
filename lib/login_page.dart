import 'package:flutter/material.dart';
import 'home_page.dart';
import 'admin_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _errorMessage;

  // ✅ Daftar akun (username : password)
  final Map<String, String> _users = {
  "admin": "0000",
  "masyarakat": "1234",
  "walikota": "1212",
  "presiden": "9090",
};


  // ✅ Login logic
  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (_users.containsKey(username) && _users[username] == password) {
      if (username == "admin") {
        // Jika admin, buka halaman admin
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminPage()),
        );
      } else {
        // Jika bukan admin, buka halaman utama biasa
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage(username: username)),
        );
      }
    } else {
      setState(() {
        _errorMessage = "❌ Username atau password salah!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF8),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo DPR
                const Icon(
                  Icons.account_balance,
                  color: Color(0xFF800000),
                  size: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Sistem Pengawasan DPR",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF800000),
                  ),
                ),
                const SizedBox(height: 30),

                // Username
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Password
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),

                const SizedBox(height: 24),

                // Tombol Login
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF800000),
                    foregroundColor: const Color(0xFFFFD700), // gold text
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),

                const SizedBox(height: 20),
                const Text(
                  "© 2025 DPR Transparency System",
                  style: TextStyle(
                    color: Color(0xFF800000),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
