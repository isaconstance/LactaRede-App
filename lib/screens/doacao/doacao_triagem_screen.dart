import 'package:flutter/material.dart';
import 'doacao_agendamento_screen.dart';
import '../../theme/app_theme.dart';
import 'doacao_agendamento_screen.dart';
import 'doacao_nao_apto_screen.dart';

class DoacaoTriagemScreen extends StatefulWidget {
  const DoacaoTriagemScreen({super.key});

  @override
  State<DoacaoTriagemScreen> createState() => _DoacaoTriagemScreenState();
}

class _DoacaoTriagemScreenState extends State<DoacaoTriagemScreen> {
  final Map<int, bool?> respostas = {};

  bool get possuiRestricao {
    // A pessoa não está se sentindo bem
    if (respostas[0] == false) {
      return true;
    }

    // A pessoa teve febre ou alguma infecção recentemente
    if (respostas[1] == true) {
      return true;
    }

    // A pessoa não está disposta a seguir as orientações
    if (respostas[3] == false) {
      return true;
    }

    return false;
  }

  final List<Map<String, dynamic>> perguntas = [
    {
      'pergunta': 'Você está se sentindo bem atualmente?',
      'descricao':
          'Não deve apresentar sintomas de doenças ou estar com mal-estar.',
    },
    {
      'pergunta': 'Teve febre ou alguma infecção recentemente?',
      'descricao': 'Considere os últimos dias antes da realização da doação.',
    },
    {
      'pergunta': 'Está utilizando algum medicamento?',
      'descricao':
          'Informe à equipe de saúde sobre qualquer medicamento utilizado.',
    },
    {
      'pergunta': 'Está disposta a seguir as orientações da equipe?',
      'descricao':
          'As orientações são importantes para garantir uma coleta segura.',
    },
  ];

  bool get todasRespondidas =>
      respostas.length == perguntas.length &&
      respostas.values.every((resposta) => resposta != null);

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
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Vamos fazer uma triagem 💙',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Responda algumas perguntas para verificarmos '
                      'se está tudo certo para seguir com a doação.',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 24),

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
                            Icons.health_and_safety_outlined,
                            color: AppColors.primary,
                            size: 25,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Esta triagem é uma etapa inicial. '
                              'A avaliação final será realizada pela '
                              'equipe responsável pela coleta.',
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.45,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 26),

                    ...List.generate(
                      perguntas.length,
                      (index) => _buildQuestionCard(index),
                    ),

                    const SizedBox(height: 8),
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
              _buildLine(true),
              _buildStep(2, 'Dados', true),
              _buildLine(true),
              _buildStep(3, 'Triagem', true),
              _buildLine(false),
              _buildStep(4, 'Agenda', false),
            ],
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Etapa 3 de 4',
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

  Widget _buildStep(int number, String label, bool active) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? AppColors.primary : AppColors.divider,
          ),
          child: Center(
            child: Text(
              '$number',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: active ? Colors.white : AppColors.textMuted,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            color: active ? AppColors.primary : AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildLine(bool active) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(left: 4, right: 4, bottom: 18),
        color: active ? AppColors.primary : AppColors.divider,
      ),
    );
  }

  Widget _buildQuestionCard(int index) {
    final pergunta = perguntas[index];
    final resposta = respostas[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: resposta != null ? AppColors.primary : AppColors.divider,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${index + 1}. ${pergunta['pergunta']}',
            style: const TextStyle(
              fontSize: 15,
              height: 1.4,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            pergunta['descricao'],
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildAnswerButton(
                  index: index,
                  value: true,
                  label: 'Sim',
                  icon: Icons.check_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildAnswerButton(
                  index: index,
                  value: false,
                  label: 'Não',
                  icon: Icons.close_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerButton({
    required int index,
    required bool value,
    required String label,
    required IconData icon,
  }) {
    final selecionado = respostas[index] == value;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        setState(() {
          respostas[index] = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 48,
        decoration: BoxDecoration(
          color: selecionado ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selecionado ? AppColors.primary : AppColors.divider,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 19,
              color: selecionado ? Colors.white : AppColors.textSecondary,
            ),
            const SizedBox(width: 7),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: selecionado ? Colors.white : AppColors.textPrimary,
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
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: todasRespondidas
              ? () {
                  if (possuiRestricao) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DoacaoNaoAptoScreen(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DoacaoAgendamentoScreen(),
                      ),
                    );
                  }
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
