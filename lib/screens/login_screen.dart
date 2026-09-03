import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;

  final _loginFormKey = GlobalKey<FormState>();
  final _cadastroFormKey = GlobalKey<FormState>();

  // LOGIN
  final _loginEmailController = TextEditingController();
  final _loginSenhaController = TextEditingController();

  // CADASTRO
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _cepController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _cadastroEmailController = TextEditingController();
  final _cadastroSenhaController = TextEditingController();

  bool _entrando = false;
  bool _cadastrando = false;

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginSenhaController.dispose();
    _nomeController.dispose();
    _cpfController.dispose();
    _enderecoController.dispose();
    _cepController.dispose();
    _telefoneController.dispose();
    _cadastroEmailController.dispose();
    _cadastroSenhaController.dispose();
    super.dispose();
  }

  // CAMPO REUTILIZÁVEL PARA CADASTRO

  Widget campoCadastro(
    String titulo,
    String hint, {
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 7),

          TextFormField(
            controller: controller,
            validator: validator,
            obscureText: obscureText,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // BUILD PRINCIPAL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(child: isLogin ? _buildLogin() : _buildCadastro()),
    );
  }

  Future<void> _entrar() async {
    if (!_loginFormKey.currentState!.validate()) return;

    setState(() => _entrando = true);
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível entrar. Confira seus dados e tente novamente.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _entrando = false);
    }
  }

  Future<void> _cadastrar() async {
    if (!_cadastroFormKey.currentState!.validate()) return;

    setState(() => _cadastrando = true);
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cadastro realizado com sucesso! Faça login para continuar.'),
        ),
      );
      setState(() => isLogin = true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível concluir o cadastro. Tente novamente.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _cadastrando = false);
    }
  }

  // TELA DE LOGIN

  Widget _buildLogin() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Form(
          key: _loginFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 35),

              // TÍTULO
              const Text(
                'Bem-vindo!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 5),

              // SUBTÍTULO
              const Text(
                'Faça login ou cadastre-se\npara continuar',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 19, color: Colors.grey),
              ),

              const SizedBox(height: 55),

              // ABAS
              _buildAbas(),

              const SizedBox(height: 40),

              // E-MAIL
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'E-mail',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: _loginEmailController,
                validator: Validators.email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'E-mail',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // SENHA
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Senha',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: _loginSenhaController,
                validator: Validators.senha,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Insira a senha',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  ),
                ),
              ),

              // ESQUECI MINHA SENHA
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    // Tela de recuperação de senha
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(left: 4),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Esqueci minha senha',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // BOTÃO ENTRAR
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _entrando ? null : _entrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF55AFE0),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _entrando
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.4,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Entrar',
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                        ),
                ),
              ),

              const SizedBox(height: 30),

              // OU ENTRE COM
              Row(
                children: [
                  const Expanded(child: Divider(color: Colors.grey, height: 1)),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'ou entre com',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),

                  const Expanded(child: Divider(color: Colors.grey, height: 1)),
                ],
              ),

              const SizedBox(height: 18),

              // LOGIN SOCIAL
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // APPLE
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.apple,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),

                  const SizedBox(width: 38),

                  // GOOGLE
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'G',
                      style: TextStyle(
                        fontSize: 43,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4285F4),
                      ),
                    ),
                  ),

                  const SizedBox(width: 38),

                  // FACEBOOK
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1877F2),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'f',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  // TELA DE CADASTRO

  Widget _buildCadastro() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _cadastroFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 35),

              // TÍTULO
              const Text(
                'Bem-vindo!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 5),

              // SUBTÍTULO
              const Text(
                'Faça login ou cadastre-se\npara continuar',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 19, color: Colors.grey),
              ),

              const SizedBox(height: 55),

              // ABAS
              _buildAbas(),

              const SizedBox(height: 40),

              // CAMPOS DE CADASTRO
              campoCadastro(
                'Nome completo',
                'Nome Completo',
                controller: _nomeController,
                validator: (v) => Validators.obrigatorio(v, campo: 'O nome'),
              ),

              campoCadastro(
                'CPF',
                'xxx.xxx.xxx-xx',
                controller: _cpfController,
                validator: Validators.cpf,
                keyboardType: TextInputType.number,
              ),

              campoCadastro(
                'Endereço',
                'Endereço',
                controller: _enderecoController,
                validator: (v) => Validators.obrigatorio(v, campo: 'O endereço'),
              ),

              campoCadastro(
                'CEP',
                'xxxxx-xxx',
                controller: _cepController,
                validator: Validators.cep,
                keyboardType: TextInputType.number,
              ),

              campoCadastro(
                'Telefone',
                '(xx) xxxxx-xxxx',
                controller: _telefoneController,
                validator: Validators.telefone,
                keyboardType: TextInputType.phone,
              ),

              campoCadastro(
                'E-mail',
                'E-mail',
                controller: _cadastroEmailController,
                validator: Validators.email,
                keyboardType: TextInputType.emailAddress,
              ),

              campoCadastro(
                'Senha',
                'Insira a senha',
                controller: _cadastroSenhaController,
                validator: Validators.senha,
                obscureText: true,
              ),

              const SizedBox(height: 15),

              // BOTÃO CADASTRAR
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _cadastrando ? null : _cadastrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF55AFE0),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _cadastrando
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.4,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Cadastrar',
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                        ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ABAS ENTRAR / CADASTRAR

  Widget _buildAbas() {
    return Row(
      children: [
        // ENTRAR
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isLogin = true;
              });
            },
            child: Column(
              children: [
                Text(
                  'Entrar',
                  style: TextStyle(
                    fontSize: 22,
                    color: isLogin ? const Color(0xFF55AFE0) : Colors.grey[700],
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  height: 1.5,
                  color: isLogin ? const Color(0xFF55AFE0) : Colors.grey,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 8),

        // CADASTRAR
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isLogin = false;
              });
            },
            child: Column(
              children: [
                Text(
                  'Cadastrar',
                  style: TextStyle(
                    fontSize: 22,
                    color: !isLogin
                        ? const Color(0xFF55AFE0)
                        : Colors.grey[700],
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  height: 1.5,
                  color: !isLogin ? const Color(0xFF55AFE0) : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}