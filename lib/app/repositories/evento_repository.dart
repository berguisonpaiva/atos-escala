import 'dart:convert';

import 'package:escala/app/helpers/rest_client.dart';
import 'package:escala/app/models/evento_model.dart';
import 'package:escala/app/models/user_model.dart';

class EventoRepository {
  final RestClient restClient;
  EventoRepository(this.restClient);

  Future<List<EventoModel>> findAll(String token) async {
    String tokenRequest = 'Bearer ' + token;
    final response = await restClient.get<List<EventoModel>>('/evento/ativo',
        headers: {'Authorization': tokenRequest}, decoder: (resp) {
      if (resp is List) {
        return resp.map<EventoModel>((ev) => EventoModel.fromMap(ev)).toList();
      }
      return null;
    });
    if (response.hasError) {
      throw RestClientException('Erro ao buscar Evento');
    }
    return response.body;
  }
}
