import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'doacao_dados_screen.dart';

class DoacaoPrerequisitosScreen extends StatefulWidget {
  const DoacaoPrerequisitosScreen({super.key});

  @override
  State<DoacaoPrerequisitosScreen> createState() =>
      _DoacaoPrerequisitosScreenState();
}

class _DoacaoPrerequisitosScreenState
    extends State<DoacaoPrerequisitosScreen> {
  final List<String> requisitos = [
    'Estou amamentando atualmente.',
    'Estou saudável e não estou com sintomas de doenças.',
    'Não faço uso de medicamentos que impeçam a doação.',
    'Não faço uso de álcool ou cigarro em excesso.',
    'Estou disposta a seguir as orientações de higiene para a coleta.',
  ];

  final Set<int> selecionados = {};

  bool get podeContinuar =>
      selecionados.length == requisitos.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Quero doar',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          children: [
            _buildProgress(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Antes de começar 💙',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Confira se você atende aos requisitos para '
                      'realizar a doação de leite materno.',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 26),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: AppColors.primary,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Leia cada item com atenção. '
                              'Para continuar, você precisa confirmar '
                              'todos os requisitos.',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.45,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Você atende aos requisitos?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 14),

                    ...List.generate(
                      requisitos.length,
                      (index) => _buildRequirementCard(index),
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgress() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        children: [
          Row(
            children: [
              _buildStep(1, 'Requisitos', true),
              _buildLine(false),
              _buildStep(2, 'Dados', false),
              _buildLine(false),
              _buildStep(3, 'Triagem', false),
              _buildLine(false),
              _buildStep(4, 'Agenda', false),
            ],
          ),

          const SizedBox(height: 8),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Etapa 1 de 4',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(
    int number,
    String label,
    bool active,
  ) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active
                ? AppColors.primary
                : AppColors.divider,
          ),
          child: Center(
            child: Text(
              '$number',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: active
                    ? Colors.white
                    : AppColors.textMuted,
              ),
            ),
          ),
        ),

        const SizedBox(height: 5),

        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: active
                ? FontWeight.w700
                : FontWeight.w500,
            color: active
                ? AppColors.primary
                : AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildLine(bool active) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(
          left: 4,
          right: 4,
          bottom: 18,
        ),
        color: active
            ? AppColors.primary
            : AppColors.divider,
      ),
    );
  }

  Widget _buildRequirementCard(int index) {
    final selecionado = selecionados.contains(index);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (selecionado) {
            selecionados.remove(index);
          } else {
            selecionados.add(index);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selecionado
                ? AppColors.primary
                : AppColors.divider,
            width: selecionado ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selecionado
                    ? AppColors.primary
                    : AppColors.surface,
                border: Border.all(
                  color: selecionado
                      ? AppColors.primary
                      : AppColors.textMuted,
                  width: 2,
                ),
              ),
              child: selecionado
                  ? const Icon(
                      Icons.check_rounded,
                      size: 18,
                      color: Colors.white,
                    )
                  : null,
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                requisitos[index],
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.divider,
          ),
        ),
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
                      builder: (_) => const DoacaoDadosScreen(),
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
            'Continuar',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}