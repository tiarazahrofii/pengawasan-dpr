import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.jpg", width: 120),
            const SizedBox(height: 20),
            const Text(
              "Pengawasan DPR",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.pink),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
              child: const Text("Masuk", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
