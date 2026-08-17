import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;

  // CAMPO REUTILIZÁVEL PARA CADASTRO

  Widget campoCadastro(String titulo, String hint, {bool obscureText = false}) {
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

          TextField(
            obscureText: obscureText,
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

  // TELA DE LOGIN

  Widget _buildLogin() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
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

            TextField(
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

            TextField(
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
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF55AFE0),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
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
    );
  }

  // TELA DE CADASTRO

  Widget _buildCadastro() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
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
            campoCadastro('Nome completo', 'Nome Completo'),

            campoCadastro('CPF', 'xxx.xxx.xxx-xx'),

            campoCadastro('Endereço', 'Endereço'),

            campoCadastro('CEP', 'xxxxx-xxx'),

            campoCadastro('Telefone', '(xx) xxxxx-xxxx'),

            campoCadastro('E-mail', 'E-mail'),

            campoCadastro('Senha', 'Insira a senha', obscureText: true),

            const SizedBox(height: 15),

            // BOTÃO CADASTRAR
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  print('Cadastro');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF55AFE0),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
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
