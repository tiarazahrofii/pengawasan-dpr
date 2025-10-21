import 'package:flutter/material.dart';
import 'home_page.dart';

const Color primaryRed = Color(0xFFE53935);
const Color greyText = Color(0xFF757575);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorText;
  bool _isPasswordVisible = false;

  final Map<String, String> _validCredentials = {
    'admin': '0000',
    'masyarakat': '1234',
    'walikota': '1212',
    'presiden': '9090',
  };

  void _login() {
    final username = _usernameController.text.trim().toLowerCase();
    final password = _passwordController.text.trim();
    
    setState(() => _errorText = null);

    if (username.isEmpty || password.isEmpty) {
      setState(() => _errorText = 'Nama pengguna dan kata sandi tidak boleh kosong.');
      return;
    }

    if (!_validCredentials.containsKey(username) || _validCredentials[username] != password) {
      setState(() => _errorText = 'Kredensial salah. Pastikan pengguna dan sandi benar.');
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(username: username)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Expanded(
                flex: 5,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Selamat Datang', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900)),
                          const SizedBox(height: 10),
                          const Text('Masuk untuk mengakses Dashboard Transparansi Kinerja DPR RI.', style: TextStyle(fontSize: 16, color: greyText)),
                          const SizedBox(height: 40),
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Nama Pengguna',
                              prefixIcon: const Icon(Icons.person, color: primaryRed),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              errorText: _errorText,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Kata Sandi',
                              prefixIcon: const Icon(Icons.lock, color: primaryRed),
                              suffixIcon: IconButton(
                                icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                                onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(backgroundColor: primaryRed, padding: const EdgeInsets.symmetric(vertical: 18)),
                            child: const Text('MASUK KE DASHBOARD', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  color: primaryRed,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.account_balance, size: 150, color: Colors.white),
                        SizedBox(height: 30),
                        Text('Transparansi Kinerja Legislatif', textAlign: TextAlign.center, style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
