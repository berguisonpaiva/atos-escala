import 'dart:convert';

class VoluntarioModel {
  final int id;
  final String nome;
  final String contato;

  VoluntarioModel({this.id, this.nome, this.contato});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'contato': contato,
    };
  }

  factory VoluntarioModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return VoluntarioModel(
      id: map['id'],
      nome: map['nome'],
      contato: map['contato'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VoluntarioModel.fromJson(String source) =>
      VoluntarioModel.fromMap(json.decode(source));
}
