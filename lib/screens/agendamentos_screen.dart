import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AgendamentosScreen extends StatefulWidget {
  const AgendamentosScreen({super.key});

  @override
  State<AgendamentosScreen> createState() => _AgendamentosScreenState();
}

class _AgendamentosScreenState extends State<AgendamentosScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> proximos = [
    {
      "titulo": "Banco de Leite Humano",
      "local": "Hospital Santa Maria",
      "status": "Confirmado",
      "data": "Segunda, 26/05/2025 às 09:00",
      "endereco": "Av. Central, 123 · Centro · 2,3 km",
    },
    {
      "titulo": "Posto de Coleta - Maternidade",
      "local": "Maternidade Esperança",
      "status": "Pendente",
      "data": "Quarta, 28/05/2025 às 14:30",
      "endereco": "Rua das Flores, 45 · Centro · 3,1 km",
    },
  ];

  final List<Map<String, dynamic>> passados = [
    {
      "titulo": "Banco de Leite Humano",
      "local": "Hospital São Lucas",
      "status": "Finalizado",
      "data": "Segunda, 12/05/2025 às 10:00",
      "endereco": "Av. Paulista, 500 · Bela Vista · 5,0 km",
    },
  ];

  final List<Map<String, dynamic>> cancelados = [
    {
      "titulo": "Posto de Coleta - UBS",
      "local": "UBS Jardim Esperança",
      "status": "Cancelado",
      "data": "Quarta, 15/05/2025 às 15:00",
      "endereco": "Rua Verde, 100 · Jardim · 4,2 km",
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

  Color _statusColor(String status) {
    switch (status) {
      case "Confirmado":
        return Colors.green;
      case "Pendente":
        return Colors.orange;
      case "Cancelado":
        return AppColors.danger;
      case "Finalizado":
        return AppColors.textSecondary;
      default:
        return AppColors.textSecondary;
    }
  }

  Color _statusBackground(String status) {
    switch (status) {
      case "Confirmado":
        return Colors.green.withOpacity(0.10);
      case "Pendente":
        return Colors.orange.withOpacity(0.12);
      case "Cancelado":
        return AppColors.dangerBg;
      case "Finalizado":
        return AppColors.divider;
      default:
        return AppColors.divider;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case "Confirmado":
        return Icons.check_circle_outline;
      case "Pendente":
        return Icons.schedule_outlined;
      case "Cancelado":
        return Icons.cancel_outlined;
      case "Finalizado":
        return Icons.check_circle_outline;
      default:
        return Icons.info_outline;
    }
  }

  Widget _buildCard(Map<String, dynamic> agendamento) {
    final status = agendamento["status"] as String;
    final statusColor = _statusColor(status);

    final podeCancelar = status == "Confirmado" || status == "Pendente";

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.water_drop_outlined,
                  color: AppColors.primary,
                  size: 23,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      agendamento["titulo"],
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      agendamento["local"],
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: _statusBackground(status),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_statusIcon(status), size: 16, color: statusColor),
                const SizedBox(width: 6),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Data
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  agendamento["data"],
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Endereço
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  agendamento["endereco"],
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          const Divider(height: 1, color: AppColors.divider),

          const SizedBox(height: 8),

          // Ações
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Detalhes do agendamento')),
                  );
                },
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                child: const Text(
                  'Ver detalhes',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              if (podeCancelar) ...[
                const SizedBox(width: 4),
                TextButton(
                  onPressed: () {
                    _mostrarDialogoCancelar(agendamento);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.danger,
                  ),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoCancelar(Map<String, dynamic> agendamento) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Cancelar agendamento?',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          content: const Text(
            'Tem certeza que deseja cancelar este agendamento?',
            style: TextStyle(color: AppColors.textSecondary, height: 1.4),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Voltar',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Agendamento cancelado.')),
                );
              },
              child: const Text(
                'Cancelar agendamento',
                style: TextStyle(
                  color: AppColors.danger,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState(IconData icon, String titulo, String descricao) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.45),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 36, color: AppColors.primary),
            ),
            const SizedBox(height: 20),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              descricao,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(
    List<Map<String, dynamic>> lista,
    IconData icon,
    String titulo,
    String descricao,
  ) {
    if (lista.isEmpty) {
      return _buildEmptyState(icon, titulo, descricao);
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      itemCount: lista.length,
      itemBuilder: (context, index) {
        return _buildCard(lista[index]);
      },
    );
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
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/inicio', (route) => false);
          },
        ),

        centerTitle: true,
        
        title: const Text(
          'Meus agendamentos',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),

        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.label,
          dividerColor: AppColors.divider,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          tabs: const [
            Tab(text: 'Próximos'),
            Tab(text: 'Passados'),
            Tab(text: 'Cancelados'),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent(
            proximos,
            Icons.calendar_today_outlined,
            'Nenhum agendamento próximo',
            'Quando você agendar uma doação,\n'
                'ela aparecerá aqui.',
          ),
          _buildTabContent(
            passados,
            Icons.history,
            'Nenhum agendamento passado',
            'Suas doações realizadas aparecerão aqui.',
          ),
          _buildTabContent(
            cancelados,
            Icons.event_busy_outlined,
            'Nenhum agendamento cancelado',
            'Agendamentos cancelados aparecerão aqui.',
          ),
        ],
      ),
    );
  }
}
