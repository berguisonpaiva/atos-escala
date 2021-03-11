import 'package:escala/app/helpers/rest_client.dart';
import 'package:escala/app/models/user_model.dart';
import 'package:escala/app/models/voluntario_model.dart';

class VoluntarioRepository {
  final RestClient restClient;
  VoluntarioRepository(this.restClient);

  Future<List<VoluntarioModel>> findAll(String token) async {
    String tokenRequest = 'Bearer ' + token;
    final response = await restClient.get<List<VoluntarioModel>>('/voluntario/',
        headers: {'Authorization': tokenRequest}, decoder: (resp) {
      if (resp is List) {
        return resp
            .map<VoluntarioModel>((ev) => VoluntarioModel.fromMap(ev))
            .toList();
      }
      return null;
    });
    if (response.hasError) {
      throw RestClientException('Erro ao buscar Voluntario');
    }
    return response.body;
  }

  Future<VoluntarioModel> findById(int minId, String token) async {
    String tokenRequest = 'Bearer ' + token;
    final response = await restClient.get<VoluntarioModel>('/voluntario/$minId',
        headers: {'Authorization': tokenRequest}, decoder: (resp) {
      if (resp != '') {
        return VoluntarioModel.fromMap(resp);
      }
      return null;
    });
    if (response.hasError) {
      throw RestClientException('Erro ao buscar Voluntario');
    }
    return response.body;
  }

  Future<VoluntarioModel> saveVolutario(
      String nome, String contato, UserModel user) async {
    String tokenRequest = 'Bearer ' + user.token;
    final response = await restClient.post(
      '/voluntario/',
      {
        'nome': nome,
        'contato': contato,
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
      String message = 'Erro ao salvar Voluntario ';

      if (response.statusCode == 400) {
        message = 'Voluntario já cadastrado';
      }
      if (response.statusCode == 500) {
        message = 'Erro ao salvar Voluntario';
      }
      throw RestClientException(message);
    }
    return response.body;
  }

  Future<VoluntarioModel> atualizarVoluntario(
      int id, String nome, String contato, UserModel user) async {
    String tokenRequest = 'Bearer ' + user.token;
    final response = await restClient.put(
      '/voluntario/',
      {
        'id': id,
        'nome': nome,
        'contato': contato,
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
      String message = 'Erro ao salvar Voluntario ';

      if (response.statusCode == 400) {
        message = 'Voluntario já cadastrado';
      }
      if (response.statusCode == 500) {
        message = 'Erro ao salvar Voluntario';
      }
      if (response.statusCode == 404) {
        message = 'Voluntario não existe';
      }
      throw RestClientException(message);
    }
    return response.body;
  }

  Future<VoluntarioModel> deletarVoluntario(int id, UserModel user) async {
    String tokenRequest = 'Bearer ' + user.token;
    final response = await restClient.delete(
      '/voluntario/$id',
      headers: {'Authorization': tokenRequest},
      decoder: (resp) {
        if (resp != '') {
          return null;
        }
      },
    );
    if (response.hasError) {
      print(response.request);
      String message = 'Erro ao deletar Voluntario ';

      if (response.statusCode == 400) {
        message = 'Erro';
      }
      if (response.statusCode == 500) {
        message = 'Erro ao deletar Voluntario';
      }
      if (response.statusCode == 404) {
        message = 'Voluntario não existe';
      }
      throw RestClientException(message);
    }
    return response.body;
  }
}
