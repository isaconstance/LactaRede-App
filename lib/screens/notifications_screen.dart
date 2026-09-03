import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Agendamento confirmado',
      'subtitle': 'Sua coleta foi agendada para 25/09/2026 às 14h00.',
      'icon': Icons.event_available_outlined,
      'read': false,
    },
    {
      'title': 'Triagem aprovada',
      'subtitle':
          'Você preencheu os requisitos para doar leite materno. Agradecemos muito por querer ajudar!',
      'icon': Icons.check_circle_outline,
      'read': true,
    },
    {
      'title': 'Sua doação faz a diferença',
      'subtitle':
          'O leite doado por você pode ajudar até 10 bebês prematuros por dia.',
      'icon': Icons.favorite_outline,
      'read': false,
    },
    {
      'title': 'Novo ponto de coleta',
      'subtitle':
          'Há um novo ponto de coleta perto de você. Confira a localização.',
      'icon': Icons.location_on_outlined,
      'read': true,
    },
    {
      'title': 'Atualização do aplicativo',
      'subtitle':
          'Uma nova versão do LactaRede está disponível. Atualize agora!',
      'icon': Icons.system_update_outlined,
      'read': true,
    },
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _filterNotifications(int index) {
    if (index == 1) {
      return notifications.where((n) => !n['read']).toList();
    }

    if (index == 2) {
      return notifications.where((n) => n['read']).toList();
    }

    return notifications;
  }

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
          'Notificações',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),

        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textMuted,
          indicatorColor: AppColors.primary,
          indicatorWeight: 2.5,
          dividerColor: AppColors.divider,
          tabs: const [
            Tab(text: 'Todas'),
            Tab(text: 'Não lidas'),
            Tab(text: 'Lidas'),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: List.generate(3, (index) {
          final filtered = _filterNotifications(index);

          if (filtered.isEmpty) {
            return const _EmptyNotifications();
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            itemCount: filtered.length,
            itemBuilder: (context, i) {
              final notification = filtered[i];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _NotificationCard(
                  title: notification['title'],
                  subtitle: notification['subtitle'],
                  icon: notification['icon'],
                  read: notification['read'],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool read;

  const _NotificationCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.read,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: read
                ? AppColors.surface
                : AppColors.accent.withOpacity(0.18),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: read
                  ? AppColors.divider
                  : AppColors.primaryLight.withOpacity(0.55),
            ),
            boxShadow: AppShadows.card,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: AppColors.primary, size: 23),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),

                        if (!read) ...[
                          const SizedBox(width: 8),
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(top: 5),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12.5,
                        height: 1.4,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      read ? 'Lida' : 'Não lida',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: read ? AppColors.textMuted : AppColors.primary,
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

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.45),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_outlined,
                color: AppColors.primary,
                size: 34,
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'Nenhuma notificação',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Quando houver novas atualizações,\nelas aparecerão aqui.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.5,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
