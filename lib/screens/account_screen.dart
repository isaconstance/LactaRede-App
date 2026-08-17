import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text(
          'Minha conta',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const _ProfileHeader(),
          const SizedBox(height: 28),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.card),
              boxShadow: AppShadows.card,
            ),
            child: Column(
              children: const [
                _AccountTile(icon: Icons.person_outline, label: 'Meus Dados'),
                _TileDivider(),
                _AccountTile(icon: Icons.water_drop_outlined, label: 'Minhas Doações'),
                _TileDivider(),
                _AccountTile(icon: Icons.notifications_none, label: 'Notificações'),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const _BrandMark(),
          const SizedBox(height: 40),
          OutlinedButton(
            onPressed: () {},
            child: const Text('Sair'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.danger,
              backgroundColor: AppColors.dangerBg,
              side: BorderSide.none,
            ),
            onPressed: () {},
            child: const Text('Excluir Conta'),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.gradientHeader,
          ),
          child: const CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: AppColors.primary, size: 32),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mariana Ribeiro', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 2),
              Text('mari.ribeiro@gmail.com', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12),
              SizedBox(
                height: 36,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  onPressed: () {},
                  child: const Text('Editar Perfil'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AccountTile extends StatelessWidget {
  final IconData icon;
  final String label;
  const _AccountTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 19, color: AppColors.primaryDark),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(label, style: Theme.of(context).textTheme.bodyLarge),
              ),
              Icon(Icons.chevron_right, color: AppColors.textMuted, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _TileDivider extends StatelessWidget {
  const _TileDivider();
  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Divider(height: 1, color: AppColors.divider),
      );
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'images/logo_lactare.png',
        height: 90,
      ),
    );
  }
}