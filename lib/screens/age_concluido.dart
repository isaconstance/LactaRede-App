import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

//Tela exibida após o usuário concluir um agendamento de doação

class AgentamentoConcluidoScreen extends StatelessWidget {
  const AgentamentoConcluidoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: AppColors.primary,
                  size: 56,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Agendamento\nrealizado',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 12),
              Text(
                'O LactaRede agradece sua contribuição.'
                'Continue sendo parte dessa corrente do bem!',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontSize: 14.5),
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // navegar para tela de detalhes do agendamento
                  },
                  child: const Text('Ver Agendamento'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryLight,
                  ),
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil('/inicio', (route) => false);
                  },
                  child: const Text('Voltar para a tela inicial'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
