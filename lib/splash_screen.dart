import 'package:flutter/material.dart';
import 'login_page.dart';

const Color sunsetDeepRed = Color(0xFFC62828);
const Color sunsetOrange = Color(0xFFF9A825);
const Color sunsetPink = Color(0xFFF48FB1);

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [sunsetDeepRed, sunsetOrange, sunsetPink],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_balance_sharp, size: 100, color: Colors.white),
                const SizedBox(height: 25),
                const Text(
                  'Transparansi Kinerja DPR RI',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Mewujudkan Akuntabilitas untuk Bangsa',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white70, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 40),
                const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                const SizedBox(height: 20),
                const Text('Memuat data...', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Text(
              '© 2025 Tiara Zahrofi Ifadhah',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.white60),
            ),
          ),
        ],
      ),
    );
  }
}
