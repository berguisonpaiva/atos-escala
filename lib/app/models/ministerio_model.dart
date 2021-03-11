import 'dart:convert';

import 'package:escala/app/models/voluntario_model.dart';

class MinisterioModel {
  final int id;
  final String nome;
  final String lider;
  final List<VoluntarioModel> voluntarios;

  MinisterioModel(this.id, this.nome, this.lider, this.voluntarios);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'lider': lider,
      'voluntarios': voluntarios?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory MinisterioModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MinisterioModel(
      map['id'],
      map['nome'],
      map['lider'],
      List<VoluntarioModel>.from(
          map['voluntarios']?.map((x) => VoluntarioModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MinisterioModel.fromJson(String source) =>
      MinisterioModel.fromMap(json.decode(source));
}
