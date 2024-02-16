class Cliente {
  int? id;
  String nomeCompleto;
  String dataNasc;
  String celular;
  String email;
  int cep;
  String logradouro;
  int numero;
  String cidade;
  String observacao;
  String imagePath;

  Cliente({
    this.id,
    required this.nomeCompleto,
    required this.dataNasc,
    required this.celular,
    required this.email,
    required this.cep,
    required this.logradouro,
    required this.numero,
    required this.cidade,
    required this.observacao,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nomeCompleto": nomeCompleto,
      "dataNasc": dataNasc,
      "celular": celular,
      "email": email,
      "cep": cep,
      "logradouro": logradouro,
      "numero": numero,
      "cidade": cidade,
      "observacao": observacao,
      "imagePath": imagePath,
    };
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'],
      nomeCompleto: map['nomeCompleto'],
      dataNasc: map['dataNasc'],
      celular: map['celular'],
      email: map['email'],
      cep: map['cep'],
      logradouro: map['logradouro'],
      numero: map['numero'],
      cidade: map['cidade'],
      observacao: map['observacao'],
      imagePath: map['imagePath'],
    );
  }
}
