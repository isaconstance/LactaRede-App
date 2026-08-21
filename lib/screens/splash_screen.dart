import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 45),

            Image.asset(
              'images/logo.png',
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 5),

            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Arial',
                ),
                children: [
                  TextSpan(
                    text: 'LACTA',
                    style: TextStyle(color: Color(0xFF00549A)),
                  ),
                  TextSpan(
                    text: 'REDE',
                    style: TextStyle(color: Color(0xFF51AEE0)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 2),

            const Text(
              'Doe amor, alimente vidas',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),

            const SizedBox(height: 55),

            Expanded(
              child: Image.asset(
                'images/mae_amamentando.png',
                width: 280,
                height: 280,
                fit: BoxFit.contain,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 35),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF55AFE0),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  child: const Text(
                    'COMEÇAR',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
