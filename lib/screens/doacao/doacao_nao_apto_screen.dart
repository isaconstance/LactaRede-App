import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class DoacaoNaoAptoScreen extends StatelessWidget {
  const DoacaoNaoAptoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.textPrimary,
        centerTitle: true,
        title: const Text(
          'Quero doar',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // Ilustração
              Image.asset('images/bebe.png', height: 190, fit: BoxFit.contain),

              const SizedBox(height: 20),

              const Text(
                'Por enquanto, não podemos\n'
                'prosseguir com o agendamento.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  height: 1.25,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 14),

              const Text(
                'Pelas informações preenchidas na triagem, '
                'é importante não realizar o agendamento neste momento.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 24),

              // Orientação
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider),
                  boxShadow: AppShadows.card,
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.health_and_safety_outlined,
                      color: AppColors.primary,
                      size: 25,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Isso não significa que você não poderá doar. '
                        'A equipe responsável poderá orientar você '
                        'sobre quando será seguro realizar a doação.',
                        style: TextStyle(
                          fontSize: 13.5,
                          height: 1.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Mas não se preocupe 💙',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
              ),

              const SizedBox(height: 4),

              const Text(
                'Você ainda pode contribuir!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 28),

              // Entender os pré-requisitos
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/inicio');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Entender os pré-requisitos',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Voltar para o início
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil('/inicio', (route) => false);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Voltar para o início',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
