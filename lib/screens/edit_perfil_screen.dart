import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/endereco.dart';
import '../models/user_profile.dart';
import '../services/cep_service.dart';
import '../utils/validators.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile perfilAtual;

  const EditProfileScreen({super.key, required this.perfilAtual});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late final _nomeController = TextEditingController(text: widget.perfilAtual.nome);
  late final _cpfController = TextEditingController(text: widget.perfilAtual.cpf);
  late final _cepController = TextEditingController(text: widget.perfilAtual.cep);
  late final _ruaController = TextEditingController(text: widget.perfilAtual.rua);
  late final _numeroController = TextEditingController(text: widget.perfilAtual.numero);
  late final _complementoController = TextEditingController(text: widget.perfilAtual.complemento);
  late final _bairroController = TextEditingController(text: widget.perfilAtual.bairro);
  late final _cidadeController = TextEditingController(text: widget.perfilAtual.cidade);
  late final _ufController = TextEditingController(text: widget.perfilAtual.uf);
  late final _telefoneController = TextEditingController(text: widget.perfilAtual.telefone);
  late final _emailController = TextEditingController(text: widget.perfilAtual.email);
  final _senhaController = TextEditingController();

  bool _salvando = false;

  final _cepService = CepService();
  bool _buscandoCep = false;
  String? _cepEncontrado; 

  Future<void> _buscarCep(String value) async {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length != 8 || digits == _cepEncontrado) return;

    setState(() => _buscandoCep = true);

    try {
      final Endereco endereco = await _cepService.buscarEnderecoPorCep(digits);
      if (!mounted) return;
      setState(() {
        _ruaController.text = endereco.logradouro;
        _bairroController.text = endereco.bairro;
        _cidadeController.text = endereco.cidade;
        _ufController.text = endereco.uf;
        _cepEncontrado = digits;
      });
      
      FocusScope.of(context).requestFocus(_numeroFocusNode);
    } on CepNaoEncontradoException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('CEP não encontrado. Confira o número digitado.'),
          backgroundColor: AppColors.danger,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
          backgroundColor: AppColors.danger,
        ),
      );
    } finally {
      if (mounted) setState(() => _buscandoCep = false);
    }
  }

  final _numeroFocusNode = FocusNode();

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _cepController.dispose();
    _ruaController.dispose();
    _numeroController.dispose();
    _complementoController.dispose();
    _bairroController.dispose();
    _cidadeController.dispose();
    _ufController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _numeroFocusNode.dispose();
    super.dispose();
  }

  String? _obrigatorio(String? value, {String campo = 'Este campo'}) =>
      Validators.obrigatorio(value, campo: campo);

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Corrija os campos destacados antes de salvar.'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    setState(() => _salvando = true);

    try {
      await Future.delayed(const Duration(milliseconds: 600));

      final perfilAtualizado = widget.perfilAtual.copyWith(
        nome: _nomeController.text.trim(),
        cpf: _cpfController.text.trim(),
        cep: _cepController.text.trim(),
        rua: _ruaController.text.trim(),
        numero: _numeroController.text.trim(),
        complemento: _complementoController.text.trim(),
        bairro: _bairroController.text.trim(),
        cidade: _cidadeController.text.trim(),
        uf: _ufController.text.trim(),
        telefone: _telefoneController.text.trim(),
        email: _emailController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Perfil atualizado com sucesso!'),
          backgroundColor: AppColors.primary,
        ),
      );
      Navigator.of(context).pop(perfilAtualizado);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível salvar: tente novamente.'),
          backgroundColor: AppColors.danger,
        ),
      );
    } finally {
      if (mounted) setState(() => _salvando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Editar Perfil'),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          children: [
            _campo(
              label: 'Nome completo',
              controller: _nomeController,
              validator: (v) => _obrigatorio(v, campo: 'O nome'),
            ),
            _campo(
              label: 'CPF',
              controller: _cpfController,
              validator: Validators.cpf,
              keyboardType: TextInputType.number,
            ),
            _campo(
              label: 'CEP',
              controller: _cepController,
              validator: Validators.cep,
              keyboardType: TextInputType.number,
              onChanged: _buscarCep,
              hint: 'Digite para preencher o endereço automaticamente',
              suffixIcon: _buscandoCep
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : (_cepEncontrado != null
                      ? const Icon(Icons.check_circle, color: AppColors.primary, size: 20)
                      : null),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _campo(
                    label: 'Rua',
                    controller: _ruaController,
                    validator: (v) => _obrigatorio(v, campo: 'A rua'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _campo(
                    label: 'Número',
                    controller: _numeroController,
                    validator: (v) => _obrigatorio(v, campo: 'O número'),
                    keyboardType: TextInputType.number,
                    focusNode: _numeroFocusNode,
                  ),
                ),
              ],
            ),
            _campo(
              label: 'Complemento (opcional)',
              controller: _complementoController,
              validator: (_) => null,
              hint: 'Apto, bloco, casa...',
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _campo(
                    label: 'Bairro',
                    controller: _bairroController,
                    validator: (v) => _obrigatorio(v, campo: 'O bairro'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _campo(
                    label: 'UF',
                    controller: _ufController,
                    validator: (v) => _obrigatorio(v, campo: 'A UF'),
                  ),
                ),
              ],
            ),
            _campo(
              label: 'Cidade',
              controller: _cidadeController,
              validator: (v) => _obrigatorio(v, campo: 'A cidade'),
            ),
            _campo(
              label: 'Telefone',
              controller: _telefoneController,
              validator: Validators.telefone,
              keyboardType: TextInputType.phone,
            ),
            _campo(
              label: 'E-mail',
              controller: _emailController,
              validator: Validators.email,
              keyboardType: TextInputType.emailAddress,
            ),
            _campo(
              label: 'Nova senha (opcional)',
              controller: _senhaController,
              validator: Validators.senhaOpcional,
              obscureText: true,
              hint: 'Deixe em branco para manter a atual',
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _salvando ? null : _salvar,
                child: _salvando
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Salvar Alterações'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campo({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? hint,
    void Function(String)? onChanged,
    Widget? suffixIcon,
    FocusNode? focusNode,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: onChanged,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.button),
                borderSide: const BorderSide(color: AppColors.divider),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.button),
                borderSide: const BorderSide(color: AppColors.divider),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.button),
                borderSide: const BorderSide(color: AppColors.danger),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.button),
                borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}