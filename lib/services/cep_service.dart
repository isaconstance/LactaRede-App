import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/endereco.dart';

class CepNaoEncontradoException implements Exception {
  const CepNaoEncontradoException();
}

class CepService {
  static const _baseUrl = 'https://viacep.com.br/ws';

  Future<Endereco> buscarEnderecoPorCep(String cep) async {
    final cepLimpo = cep.replaceAll(RegExp(r'[^0-9]'), '');

    final uri = Uri.parse('$_baseUrl/$cepLimpo/json/');

    late final http.Response response;
    try {
      response = await http.get(uri).timeout(const Duration(seconds: 8));
    } catch (_) {
      throw Exception('Sem conexão com a internet. Verifique sua rede e tente novamente.');
    }

    if (response.statusCode != 200) {
      throw Exception('Não foi possível consultar o CEP agora (erro ${response.statusCode}).');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;

  
    if (body['erro'] == true) {
      throw const CepNaoEncontradoException();
    }

    return Endereco.fromJson(body);
  }
}