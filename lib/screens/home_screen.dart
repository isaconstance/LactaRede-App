import 'package:flutter/material.dart';

import 'package:lactarede/screens/notifications_screen.dart';

import '../theme/app_theme.dart';
import '../widgets/app_drawer.dart';
import '../widgets/wave_clipper.dart';
import '../models/user_profile.dart';
import '../services/perfil_storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserProfile _perfil = UserProfile.exemplo;

  final PerfilStorageService _perfilStorage = PerfilStorageService();

  @override
  void initState() {
    super.initState();
    _carregarPerfil();
  }

  Future<void> _carregarPerfil() async {
    try {
      final perfilSalvo = await _perfilStorage.carregarPerfil();

      if (!mounted) return;

      if (perfilSalvo != null) {
        setState(() {
          _perfil = perfilSalvo;
        });
      }
    } catch (_) {
      // Mantém o perfil de exemplo caso aconteça algum erro.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        userName: _perfil.nome,
        userEmail: _perfil.email,
        currentRoute: '/inicio',
        onNavigate: (route) async {
          // Fecha o Drawer.
          Navigator.of(context).pop();

          // Se não for a própria Home, abre a tela escolhida.
          if (route != '/inicio') {
            await Navigator.of(context).pushNamed(route);

            // Quando voltar para a Home, recarrega o perfil salvo.
            if (mounted) {
              await _carregarPerfil();
            }
          }
        },
      ),
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _HomeHeader(
              nome: _perfil.nome,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const _ImpactCard(),
                const SizedBox(height: 28),
                Text(
                  'Ações Rápidas',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 14),
                const _QuickActionsRow(),
                const SizedBox(height: 28),
                Text(
                  'Fique por dentro',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 14),
                const _CampaignCard(
                  title: 'Campanha de Maio',
                  date:
                      '19/05 · Dia Mundial e Nacional da Doação de Leite Humano',
                  description:
                      'Juntos, podemos salvar mais vidas! Participe e compartilhe.',
                ),
                const SizedBox(height: 14),
                const _CampaignCard(
                  title: 'Novo Ponto de Coleta',
                  date: 'Agora perto de você',
                  description:
                      'Abrimos um novo posto de coleta na sua região. Confira o endereço e horários.',
                  icon: Icons.location_on,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  final String nome;

  const _HomeHeader({
    required this.nome,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DripWaveClipper(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 40),
        decoration: const BoxDecoration(
          gradient: AppColors.gradientHeader,
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () =>
                          Scaffold.of(context).openDrawer(),
                    ),
                  ),
                  Text(
                    'LactaRede',
                    style:
                        Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                  ),
                  const Spacer(),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationsScreen(),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFC857),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                            ),
                        children: [
                          TextSpan(
                            text: 'Olá, $nome! ',
                          ),
                          const TextSpan(
                            text: '💙',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Que bom ter você por aqui',
                      style:
                          Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white.withOpacity(0.9),
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

class _ImpactCard extends StatelessWidget {
  const _ImpactCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.favorite,
                size: 16,
                color: AppColors.primary,
              ),
              const SizedBox(width: 6),
              Text(
                'Nosso Impacto',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              _StatItem(
                value: '125',
                label: 'Doadores\ncadastrados',
              ),
              _VerticalDivider(),
              _StatItem(
                value: '1.250L',
                label: 'Leite\ndoado',
              ),
              _VerticalDivider(),
              _StatItem(
                value: '340',
                label: 'Bebês\nbeneficiados',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 1,
      color: AppColors.divider,
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.primary,
                  fontSize: 19,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context) {
    const actions = [
      (Icons.water_drop_outlined, 'Quero Doar', '/doar'),
      (Icons.info_outline, 'Informações', '/informacoes'),
      (
        Icons.location_on_outlined,
        'Pontos de\nColeta',
        '/pontos-de-coleta'
      ),
    ];

    return IntrinsicHeight(
      child: Row(
        children: actions
            .map(
              (a) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _QuickActionCard(
                    icon: a.$1,
                    label: a.$2,
                    onTap: () =>
                        Navigator.of(context).pushNamed(a.$3),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap ?? () {},
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppShadows.soft,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: AppColors.primaryDark,
                  size: 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style:
                    Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CampaignCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final IconData icon;

  const _CampaignCard({
    required this.title,
    required this.date,
    required this.description,
    this.icon = Icons.water_drop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    date,
                    style:
                        Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style:
                        Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(AppRadius.card),
              bottomRight: Radius.circular(AppRadius.card),
            ),
            child: Container(
              width: 96,
              height: 130,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.accent.withOpacity(0.6),
                    AppColors.primaryLight.withOpacity(0.4),
                  ],
                ),
              ),
              child: Icon(
                icon,
                color: AppColors.primary.withOpacity(0.5),
                size: 34,
              ),
            ),
          ),
        ],
      ),
    );
  }
}