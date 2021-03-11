import 'dart:convert';

class EscalaInputModel {
  final int evento;
  final int voluntario;
  final String ministerio;
  final int user;
  EscalaInputModel({
    this.evento,
    this.voluntario,
    this.ministerio,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'evento': evento,
      'voluntario': voluntario,
      'ministerio': ministerio,
      'user': user,
    };
  }

  factory EscalaInputModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return EscalaInputModel(
      evento: map['evento'],
      voluntario: map['voluntario'],
      ministerio: map['ministerio'],
      user: map['user'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EscalaInputModel.fromJson(String source) =>
      EscalaInputModel.fromMap(json.decode(source));
}
