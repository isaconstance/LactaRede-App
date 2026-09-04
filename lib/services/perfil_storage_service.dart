import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_profile.dart';

class PerfilStorageService {
  static const _keyNome = 'perfil_nome';
  static const _keyCpf = 'perfil_cpf';
  static const _keyRua = 'perfil_rua';
  static const _keyNumero = 'perfil_numero';
  static const _keyComplemento = 'perfil_complemento';
  static const _keyBairro = 'perfil_bairro';
  static const _keyCidade = 'perfil_cidade';
  static const _keyUf = 'perfil_uf';
  static const _keyCep = 'perfil_cep';
  static const _keyTelefone = 'perfil_telefone';
  static const _keyEmail = 'perfil_email';

  Future<void> salvarPerfil(UserProfile perfil) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_keyNome, perfil.nome);
    await prefs.setString(_keyCpf, perfil.cpf);
    await prefs.setString(_keyRua, perfil.rua);
    await prefs.setString(_keyNumero, perfil.numero);
    await prefs.setString(_keyComplemento, perfil.complemento);
    await prefs.setString(_keyBairro, perfil.bairro);
    await prefs.setString(_keyCidade, perfil.cidade);
    await prefs.setString(_keyUf, perfil.uf);
    await prefs.setString(_keyCep, perfil.cep);
    await prefs.setString(_keyTelefone, perfil.telefone);
    await prefs.setString(_keyEmail, perfil.email);
  }

  Future<UserProfile?> carregarPerfil() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey(_keyNome)) {
      return null;
    }

    return UserProfile(
      nome: prefs.getString(_keyNome) ?? '',
      cpf: prefs.getString(_keyCpf) ?? '',
      rua: prefs.getString(_keyRua) ?? '',
      numero: prefs.getString(_keyNumero) ?? '',
      complemento: prefs.getString(_keyComplemento) ?? '',
      bairro: prefs.getString(_keyBairro) ?? '',
      cidade: prefs.getString(_keyCidade) ?? '',
      uf: prefs.getString(_keyUf) ?? '',
      cep: prefs.getString(_keyCep) ?? '',
      telefone: prefs.getString(_keyTelefone) ?? '',
      email: prefs.getString(_keyEmail) ?? '',
    );
  }
}