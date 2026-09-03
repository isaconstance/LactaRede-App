class Endereco {
  final String logradouro;
  final String bairro;
  final String cidade;
  final String uf;

  const Endereco({
    required this.logradouro,
    required this.bairro,
    required this.cidade,
    required this.uf,
  });

  String get resumo {
    final partes = [
      if (logradouro.isNotEmpty) logradouro,
      if (bairro.isNotEmpty) bairro,
      if (cidade.isNotEmpty && uf.isNotEmpty) '$cidade/$uf',
    ];
    return partes.join(' - ');
  }

  factory Endereco.fromJson(Map<String, dynamic> json) {
    return Endereco(
      logradouro: json['logradouro'] ?? '',
      bairro: json['bairro'] ?? '',
      cidade: json['localidade'] ?? '',
      uf: json['uf'] ?? '',
    );
  }
}