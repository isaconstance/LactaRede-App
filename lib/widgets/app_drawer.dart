import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'wave_clipper.dart';

class AppDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String? avatarUrl;
  final String currentRoute;
  final void Function(String route) onNavigate;

  const AppDrawer({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.currentRoute,
    required this.onNavigate,
    this.avatarUrl,
  });

  static const _items = <_DrawerItem>[
    _DrawerItem('/conta', Icons.person_outline, 'Minha Conta'),
    _DrawerItem('/inicio', Icons.home_outlined, 'Início'),
    _DrawerItem('/informacoes', Icons.info_outline, 'Informações'),
    _DrawerItem('/doar', Icons.water_drop_outlined, 'Doar'),
    _DrawerItem('/agendamentos', Icons.calendar_today_outlined,'Meus Agendamentos'),
    _DrawerItem('/ajuda', Icons.help_outline, 'Ajuda e Suporte'),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      width: MediaQuery.of(context).size.width * 0.78,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              userName: userName,
              userEmail: userEmail,
              avatarUrl: avatarUrl,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 2),
                itemBuilder: (context, i) {
                  final item = _items[i];
                  final selected = item.route == currentRoute;
                  return _DrawerTitle(
                    item: item,
                    selected: selected,
                    onTap: () => onNavigate(item.route),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String? avatarUrl;

  const _Header({
    required this.userName,
    required this.userEmail,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DripWaveClipper(),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 44),
        decoration: const BoxDecoration(gradient: AppColors.gradientHeader),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: avatarUrl != null
                    ? NetworkImage(avatarUrl!)
                    : null,
                child: avatarUrl == null
                    ? const Icon(Icons.person, size: 30)
                    : null,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    userEmail,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem {
  final String route;
  final IconData icon;
  final String label;
  const _DrawerItem(this.route, this.icon, this.label);
}

class _DrawerTitle extends StatelessWidget {
  final _DrawerItem item;
  final bool selected;
  final VoidCallback onTap;

  const _DrawerTitle({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.accent.withOpacity(0.5) : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          child: Row(
            children: [
              Icon(
                item.icon,
                size: 22,
                color: selected ? AppColors.primary : AppColors.textSecondary,
              ),
              const SizedBox(width: 16),
              Text(
                item.label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
