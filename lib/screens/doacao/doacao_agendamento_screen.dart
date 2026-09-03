import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'doacao_concluido_screen.dart';

class DoacaoAgendamentoScreen extends StatefulWidget {
  const DoacaoAgendamentoScreen({super.key});

  @override
  State<DoacaoAgendamentoScreen> createState() =>
      _DoacaoAgendamentoScreenState();
}

class _DoacaoAgendamentoScreenState extends State<DoacaoAgendamentoScreen> {
  DateTime? dataSelecionada;
  String? horarioSelecionado;

  final List<String> horarios = [
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
  ];

  bool get podeContinuar =>
      dataSelecionada != null && horarioSelecionado != null;

  Future<void> selecionarData() async {
    final hoje = DateTime.now();

    final data = await showDatePicker(
      context: context,
      initialDate: hoje.add(const Duration(days: 1)),
      firstDate: hoje,
      lastDate: hoje.add(const Duration(days: 60)),
      helpText: 'Escolha a data da doação',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (data != null) {
      setState(() {
        dataSelecionada = data;
        horarioSelecionado = null;
      });
    }
  }

  String formatarData(DateTime data) {
    const meses = [
      'janeiro',
      'fevereiro',
      'março',
      'abril',
      'maio',
      'junho',
      'julho',
      'agosto',
      'setembro',
      'outubro',
      'novembro',
      'dezembro',
    ];

    return '${data.day} de ${meses[data.month - 1]} de ${data.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // AppBar padronizado
      appBar: AppBar(
        title: const Text(
          'Quero doar',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),

      body: Column(
        children: [
          _buildProgress(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Agende sua doação 📅',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Escolha uma data e um horário que sejam confortáveis para você.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Local da coleta
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: AppShadows.card,
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: AppColors.primary,
                          size: 28,
                        ),

                        SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Local da coleta',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                ),
                              ),

                              SizedBox(height: 4),

                              Text(
                                'Ponto de Coleta LactaRede',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Icon(
                          Icons.chevron_right,
                          color: AppColors.textMuted,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Escolha a data',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Seleção da data
                  InkWell(
                    onTap: selecionarData,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 17,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: dataSelecionada != null
                              ? AppColors.primary
                              : AppColors.divider,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            color: AppColors.primary,
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Text(
                              dataSelecionada == null
                                  ? 'Selecionar uma data'
                                  : formatarData(dataSelecionada!),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: dataSelecionada != null
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: dataSelecionada != null
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),

                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.textMuted,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Horários aparecem somente depois da escolha da data
                  if (dataSelecionada != null) ...[
                    const SizedBox(height: 28),

                    const Text(
                      'Escolha o horário',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: horarios.map((horario) {
                        final selecionado =
                            horarioSelecionado == horario;

                        return InkWell(
                          onTap: () {
                            setState(() {
                              horarioSelecionado = horario;
                            });
                          },
                          borderRadius: BorderRadius.circular(14),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            width: 76,
                            padding: const EdgeInsets.symmetric(
                              vertical: 13,
                            ),
                            decoration: BoxDecoration(
                              color: selecionado
                                  ? AppColors.primary
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: selecionado
                                    ? AppColors.primary
                                    : AppColors.divider,
                              ),
                            ),
                            child: Text(
                              horario,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: selecionado
                                    ? Colors.white
                                    : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Informação
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.primaryDark,
                          size: 21,
                        ),

                        SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            'O agendamento é uma previsão de atendimento. '
                            'A equipe responsável fará a avaliação final '
                            'no momento da coleta.',
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.45,
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Botão inferior
          Container(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  offset: Offset(0, -2),
                  color: Colors.black12,
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: podeContinuar
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const AgendamentoConcluidoScreen(),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: AppColors.divider,
                  foregroundColor: Colors.white,
                  disabledForegroundColor: AppColors.textMuted,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Confirmar agendamento',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgress() {
    const etapas = [
      'Requisitos',
      'Dados',
      'Triagem',
      'Agendamento',
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Column(
        children: [
          Row(
            children: List.generate(4, (index) {
              return Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    if (index < 3)
                      Expanded(
                        child: Container(
                          height: 2,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          color: AppColors.primary,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),

          const SizedBox(height: 7),

          Row(
            children: List.generate(4, (index) {
              return Expanded(
                child: Text(
                  etapas[index],
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 14),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Etapa 4 de 4',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}