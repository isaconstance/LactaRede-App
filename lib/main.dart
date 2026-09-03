import 'package:flutter/material.dart';
import 'package:lactarede/screens/agendamentos_screen.dart';
import 'package:lactarede/screens/help_screen.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/account_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/infos_screen.dart';
import 'screens/pontos_coleta_screen.dart';
import 'screens/doacao/doacao_prerequisitos_screen.dart';

void main() => runApp(const LactaRedeApp());

class LactaRedeApp extends StatelessWidget {
  const LactaRedeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LactaRede',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const SplashScreen(),
      routes: {
        '/inicio': (_) => const HomeScreen(),
        '/conta': (_) => const AccountScreen(),
        '/ajuda': (_) => const HelpScreen(),
        '/agendamentos': (_) => const AgendamentosScreen(),
        '/informacoes': (_) => const InfosScreen(),
        '/pontos-de-coleta': (_) => const PontosColetaScreen(),
        '/doar': (_) => const DoacaoPrerequisitosScreen(),
      },
    );
  }
}