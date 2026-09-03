class UserProfile {
  final String nome;
  final String cpf;
  final String rua;
  final String numero;
  final String complemento;
  final String bairro;
  final String cidade;
  final String uf;
  final String cep;
  final String telefone;
  final String email;

  const UserProfile({
    required this.nome,
    required this.cpf,
    required this.rua,
    required this.numero,
    required this.complemento,
    required this.bairro,
    required this.cidade,
    required this.uf,
    required this.cep,
    required this.telefone,
    required this.email,
  });

  String get enderecoCompleto {
    final ruaNumero = [
      if (rua.isNotEmpty) rua,
      if (numero.isNotEmpty) numero,
    ].join(', ');

    final partes = [
      if (ruaNumero.isNotEmpty) ruaNumero,
      if (complemento.isNotEmpty) complemento,
      if (bairro.isNotEmpty) bairro,
      if (cidade.isNotEmpty && uf.isNotEmpty) '$cidade/$uf',
    ];
    return partes.join(' - ');
  }

  UserProfile copyWith({
    String? nome,
    String? cpf,
    String? rua,
    String? numero,
    String? complemento,
    String? bairro,
    String? cidade,
    String? uf,
    String? cep,
    String? telefone,
    String? email,
  }) {
    return UserProfile(
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      rua: rua ?? this.rua,
      numero: numero ?? this.numero,
      complemento: complemento ?? this.complemento,
      bairro: bairro ?? this.bairro,
      cidade: cidade ?? this.cidade,
      uf: uf ?? this.uf,
      cep: cep ?? this.cep,
      telefone: telefone ?? this.telefone,
      email: email ?? this.email,
    );
  }

  /// Perfil de exemplo
  static const exemplo = UserProfile(
    nome: 'Mariana Ribeiro',
    cpf: '000.000.000-00',
    rua: 'Av. Paulista',
    numero: '500',
    complemento: '',
    bairro: 'Bela Vista',
    cidade: 'São Paulo',
    uf: 'SP',
    cep: '01310-200',
    telefone: '(11) 90000-0000',
    email: 'mari.ribeiro@gmail.com',
  );
}