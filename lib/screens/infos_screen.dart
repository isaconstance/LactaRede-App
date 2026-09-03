import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class _InfoTopic {
  final IconData icon;
  final String title;
  final String description;

  const _InfoTopic({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class InfosScreen extends StatelessWidget {
  const InfosScreen({super.key});

  static const _topicos = <_InfoTopic>[
    _InfoTopic(
      icon: Icons.assignment_turned_in_outlined,
      title: 'Pré-requisitos para doar',
      description: 'Veja quem pode realizar a doação.',
    ),
    _InfoTopic(
      icon: Icons.favorite_outline,
      title: 'Benefícios do leite humano',
      description: 'Entenda a importância do leite materno.',
    ),
    _InfoTopic(
      icon: Icons.water_drop_outlined,
      title: 'Como é feita a doação',
      description: 'Saiba como funciona o processo de coleta.',
    ),
    _InfoTopic(
      icon: Icons.local_shipping_outlined,
      title: 'Armazenamento e transporte',
      description: 'Entenda como o leite é armazenado e transportado.',
    ),
    _InfoTopic(
      icon: Icons.check_circle_outline,
      title: 'Mitos e verdades',
      description: 'Descubra o que é verdade sobre a doação.',
    ),
    _InfoTopic(
      icon: Icons.help_outline,
      title: 'Perguntas frequentes',
      description: 'Encontre respostas para dúvidas comuns.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/inicio', (route) => false);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
            size: 24,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Informações',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        children: [
          const Text(
            'Tudo sobre doação',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Encontre informações para entender melhor '
            'a doação de leite humano.',
            style: TextStyle(
              fontSize: 14.5,
              height: 1.5,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 22),
          const _SearchField(),
          const SizedBox(height: 24),
          const Text(
            'Explore os conteúdos',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._topicos.map(
            (topic) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _InfoCard(topic: topic),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Buscar conteúdo...',
          hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: AppColors.textMuted, size: 21),
          suffixIcon: Icon(
            Icons.tune_outlined,
            color: AppColors.textMuted,
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
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
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          // Abrir conteúdo futuramente
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.divider),
            boxShadow: AppShadows.card,
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(topic.icon, color: AppColors.primary, size: 23),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      topic.description,
                      style: const TextStyle(
                        fontSize: 12.5,
                        height: 1.35,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right,
                color: AppColors.textMuted,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
