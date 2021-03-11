import 'dart:convert';

class EventoModel {
  final int id;
  final String titulo;
  final String data;
  final String hora;
  final String img;
  final String status;

  EventoModel(
      this.id, this.titulo, this.data, this.hora, this.img, this.status);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'data': data,
      'hora': hora,
      'img': img,
      'status': status,
    };
  }

  factory EventoModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return EventoModel(
      map['id'],
      map['titulo'],
      map['data'],
      map['hora'],
      map['img'],
      map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventoModel.fromJson(String source) =>
      EventoModel.fromMap(json.decode(source));
}
