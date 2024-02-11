class Cliente {
  int? id;
  String nome;
  int idade;

  Cliente({this.id, required this.nome, required this.idade});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "idade": idade,
    };
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'],
      nome: map['nome'],
      idade: map['idade'],
    );
  }
}
