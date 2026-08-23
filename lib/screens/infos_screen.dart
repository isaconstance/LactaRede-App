import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class _InfoTopic {
  final IconData icon;
  final Color color;
  final String title;

  const _InfoTopic({
    required this.icon,
    required this.color,
    required this.title,
  });
}

class InfosScreen extends StatelessWidget {
  const InfosScreen({super.key});

  static const _topicos = <_InfoTopic>[
    _InfoTopic(
      icon: Icons.assignment_turned_in,
      color: Color(0xFFB39DDB),
      title: 'Pré-requisitos para doar',
    ),
    _InfoTopic(
      icon: Icons.favorite,
      color: Color(0xFFE8899A),
      title: 'Benefícios do leite humano',
    ),
    _InfoTopic(
      icon: Icons.wb_sunny,
      color: Color(0XFFF2C94C),
      title: 'Como é feita a doação',
    ),
    _InfoTopic(
      icon: Icons.local_shipping,
      color: Color(0xFF6FA8DC),
      title: 'Armazenamento e transporte',
    ),
    _InfoTopic(
      icon: Icons.check_circle,
      color: Color(0xFF6FCF97),
      title: 'Mitos e verdades sobre a doação',
    ),
    _InfoTopic(
      icon: Icons.help,
      color: Color(0XFFE0A96D),
      title: 'Perguntas frequentes',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text(
          'Informações',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        children: [
          _SearchField(),
          const SizedBox(height: 18),
          ..._topicos.map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _InfoCard(topic: t),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.button),
        boxShadow: AppShadows.soft,
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar conteúdo...',
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.textMuted,
            size: 20,
          ),
          suffixIcon: const Icon(
            Icons.tune,
            color: AppColors.textMuted,
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final _InfoTopic topic;
  const _InfoCard({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.card),
            boxShadow: AppShadows.card,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: topic.color.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(topic.icon, color: topic.color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Saiba mais',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
