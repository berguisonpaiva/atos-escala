import 'dart:convert';

class EscalaModel {
  final String ministerio;
  final String voluntario;
  EscalaModel({
    this.ministerio,
    this.voluntario,
  });

  Map<String, dynamic> toMap() {
    return {
      'ministerio': ministerio,
      'voluntario': voluntario,
    };
  }

  factory EscalaModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return EscalaModel(
      ministerio: map['ministerio'],
      voluntario: map['voluntario'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EscalaModel.fromJson(String source) =>
      EscalaModel.fromMap(json.decode(source));
}
