import 'package:escala/app/helpers/rest_client.dart';
import 'package:escala/app/models/escala_input_model.dart';
import 'package:escala/app/models/escala_model.dart';
import 'package:escala/app/models/user_model.dart';

class EscalaRepository {
  final RestClient restClient;

  EscalaRepository(
    this.restClient,
  );

  Future<List<EscalaModel>> findByEvento(int eventoId, String token) async {
    String tokenRequest = 'Bearer ' + token;
    final response = await restClient.get<List<EscalaModel>>(
        '/escala/$eventoId',
        headers: {'Authorization': tokenRequest}, decoder: (resp) {
      if (resp is List) {
        return resp.map<EscalaModel>((ev) => EscalaModel.fromMap(ev)).toList();
      }
      return null;
    });
    if (response.hasError) {
      print(response.statusCode);
      String message = 'Erro ao buscar escala ';

      if (response.statusCode == 403) {
        message = 'Usuario não autenticado';
      }
      if (response.statusCode == 404) {
        message = 'Não contem escala';
      }
      if (response.statusCode == 400) {
        message = 'Dados não validos';
      }
      throw RestClientException(message);
    }

    return response.body;
  }

  Future<EscalaInputModel> saveEscala(
      int evento, int voluntario, String ministerio, UserModel user) async {
    String tokenRequest = 'Bearer ' + user.token;
    final response = await restClient.post(
      '/escala/',
      {
        'evento': evento,
        'voluntario': voluntario,
        'ministerio': ministerio,
        'user': user.id,
      },
      headers: {'Authorization': tokenRequest},
      decoder: (resp) {
        if (resp != '') {
          return null;
        }
      },
    );
    if (response.hasError) {
      print(response.request);
      String message = 'Erro ao salvar escala ';

      if (response.statusCode == 400) {
        message = 'Voluntario já estar escalado';
      }
      throw RestClientException(message);
    }
    return response.body;
  }
}
