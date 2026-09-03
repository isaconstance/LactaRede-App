import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'doacao_triagem_screen.dart';

class DoacaoDadosScreen extends StatefulWidget {
  const DoacaoDadosScreen({super.key});

  @override
  State<DoacaoDadosScreen> createState() => _DoacaoDadosScreenState();
}

class _DoacaoDadosScreenState extends State<DoacaoDadosScreen> {
  final _formKey = GlobalKey<FormState>();

  final nomeController =
      TextEditingController(text: 'Mariana Ribeiro');

  final telefoneController =
      TextEditingController(text: '(11) 90000-0000');

  final emailController =
      TextEditingController(text: 'mari.ribeiro@gmail.com');

  final cepController =
      TextEditingController(text: '01310-200');

  @override
  void dispose() {
    nomeController.dispose();
    telefoneController.dispose();
    emailController.dispose();
    cepController.dispose();
    super.dispose();
  }

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Confirme seus dados',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'Confira se seus dados estão corretos antes de '
                        'continuar com a doação.',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: AppColors.textSecondary,
                        ),
                      ),

                      const SizedBox(height: 26),

                      _buildSectionTitle(
                        'Dados pessoais',
                        Icons.person_outline_rounded,
                      ),

                      const SizedBox(height: 14),

                      _buildTextField(
                        controller: nomeController,
                        label: 'Nome completo',
                        icon: Icons.person_outline_rounded,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Informe seu nome.';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 14),

                      _buildTextField(
                        controller: telefoneController,
                        label: 'Telefone',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Informe seu telefone.';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 14),

                      _buildTextField(
                        controller: emailController,
                        label: 'E-mail',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Informe seu e-mail.';
                          }

                          if (!value.contains('@')) {
                            return 'Informe um e-mail válido.';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 28),

                      _buildSectionTitle(
                        'Endereço',
                        Icons.location_on_outlined,
                      ),

                      const SizedBox(height: 14),

                      _buildTextField(
                        controller: cepController,
                        label: 'CEP',
                        icon: Icons.location_on_outlined,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Informe seu CEP.';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

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
                              Icons.lock_outline_rounded,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Seus dados são utilizados apenas para '
                                'identificar e organizar sua doação.',
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
                    ],
                  ),
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
              'Etapa 2 de 4',
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

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 21,
          color: AppColors.primary,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: AppColors.primary,
        ),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.divider,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.divider,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      decoration: const BoxDecoration(
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DoacaoTriagemScreen(),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
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