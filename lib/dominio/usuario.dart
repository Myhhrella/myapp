class Usuario {
  int? id;
  String nome;
  String cpf;
  String email;
  String numero;
  String senha;
  String imagem;

  Usuario({
    this.id,
    required this.nome,
    required this.cpf,
    required this.email,
    required this.numero,
    required this.senha,
    required this.imagem
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      cpf: json['cpf'],
      email: json['email'],
      numero: json['numero'],
      senha: json['senha'],
      imagem: json['imagem']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'numero': numero,
      'senha': senha,
      'imagem': imagem
    };
  }
}
