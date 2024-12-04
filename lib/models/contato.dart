class Contato {
  int? id;
  late String nome;
  late String telefone;
  late String email;

  Contato({
    this.id,
    required this.nome,
    required this.telefone,
    required this.email,
  });
 
 //Objeto para Map (Inserir no DB)

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'Nome': nome,
      'Telefone': telefone,
      'Email': email,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

//Map para objeto (Resgata do DB)
  Contato.fromMap(Map<String, Object?> map) {
    id = map['id'] as int?;
    nome = map['Nome'] as String;
    telefone = map['Telefone'] as String;
    email = map['Email'] as String;
  }
}
