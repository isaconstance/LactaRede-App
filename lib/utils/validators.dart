class Validators {
  Validators._();

  static String? obrigatorio(String? value, {String campo = 'Este campo'}) {
    if (value == null || value.trim().isEmpty) {
      return '$campo é obrigatório';
    }
    return null;
  }

  static String? email(String? value) {
    final erroObrigatorio = obrigatorio(value, campo: 'O e-mail');
    if (erroObrigatorio != null) return erroObrigatorio;
    final regex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,}$');
    if (!regex.hasMatch(value!.trim())) {
      return 'Digite um e-mail válido';
    }
    return null;
  }

  static String? cpf(String? value) {
    final erroObrigatorio = obrigatorio(value, campo: 'O CPF');
    if (erroObrigatorio != null) return erroObrigatorio;
    final digits = value!.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length != 11) {
      return 'CPF deve ter 11 dígitos';
    }
    return null;
  }

  static String? cep(String? value) {
    final erroObrigatorio = obrigatorio(value, campo: 'O CEP');
    if (erroObrigatorio != null) return erroObrigatorio;
    final digits = value!.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length != 8) {
      return 'CEP deve ter 8 dígitos';
    }
    return null;
  }

  static String? telefone(String? value) {
    final erroObrigatorio = obrigatorio(value, campo: 'O telefone');
    if (erroObrigatorio != null) return erroObrigatorio;
    final digits = value!.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length < 10) {
      return 'Telefone inválido';
    }
    return null;
  }

  /// Senha obrigatória (uso: login, cadastro).
  static String? senha(String? value) {
    final erroObrigatorio = obrigatorio(value, campo: 'A senha');
    if (erroObrigatorio != null) return erroObrigatorio;
    if (value!.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  /// Senha opcional (uso: editar perfil, onde deixar em branco mantém a atual).
  static String? senhaOpcional(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }
}