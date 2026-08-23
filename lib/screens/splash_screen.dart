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
            const Spacer(flex: 2),

            // LOGO
            Image.asset(
              'images/logo.png',
              width: 65,
              height: 65,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 10),

            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
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

            const SizedBox(height: 6),

            const Text(
              'Doe amor, alimente vidas',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
                letterSpacing: 0.2,
              ),
            ),

            const Spacer(flex: 3),

            SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Blob de fundo 
                  Container(
                    width: 320,
                    height: 320,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF51AEE0).withValues(alpha: 0.14),
                          const Color(0xFF51AEE0).withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                  Image.asset(
                    'images/mae_amamentando.png',
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),

            const Spacer(flex: 4),

            // BOTÃO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
              child: SizedBox(
                width: double.infinity,
                height: 46,
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
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'COMEÇAR',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
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