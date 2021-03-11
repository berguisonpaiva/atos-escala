import 'package:escala/app/helpers/rest_client.dart';
import 'package:escala/app/models/ministerio_model.dart';
import 'package:escala/app/models/user_model.dart';

class MinisterioRepository {
  final RestClient restClient;
  MinisterioRepository(this.restClient);

  Future<List<MinisterioModel>> findMyMisterio(UserModel user) async {
    String tokenRequest = 'Bearer ' + user.token;
    final response = await restClient.get<List<MinisterioModel>>(
        '/ministerio/user/${user.id}',
        headers: {'Authorization': tokenRequest}, decoder: (resp) {
      if (resp is List) {
        return resp
            .map<MinisterioModel>((ev) => MinisterioModel.fromMap(ev))
            .toList();
      }
      return null;
    });
    if (response.hasError) {
      throw RestClientException('Erro ao buscar Ministerio');
    }
    return response.body;
  }

  Future<List<MinisterioModel>> findAll(UserModel user) async {
    String tokenRequest = 'Bearer ' + user.token;
    final response = await restClient.get<List<MinisterioModel>>('/ministerio/',
        headers: {'Authorization': tokenRequest}, decoder: (resp) {
      if (resp is List) {
        return resp
            .map<MinisterioModel>((ev) => MinisterioModel.fromMap(ev))
            .toList();
      }
      return null;
    });
    if (response.hasError) {
      throw RestClientException('Erro ao buscar Ministerio');
    }
    return response.body;
  }

  Future<List<MinisterioModel>> findMisterioById(
      int minId, String token) async {
    String tokenRequest = 'Bearer ' + token;
    final response = await restClient.get<List<MinisterioModel>>(
        '/ministerio/$minId',
        headers: {'Authorization': tokenRequest}, decoder: (resp) {
      if (resp is List) {
        return resp
            .map<MinisterioModel>((ev) => MinisterioModel.fromMap(ev))
            .toList();
      }
      return null;
    });
    if (response.hasError) {
      throw RestClientException('Erro ao buscar Ministerio');
    }
    return response.body;
  }

  Future<MinisterioModel> saveMinisterio(
      int lider, String ministerio, UserModel user) async {
    String tokenRequest = 'Bearer ' + user.token;
    final response = await restClient.post(
      '/ministerio/',
      {
        'nome': ministerio,
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
      String message = 'Erro ao salvar ministério ';

      if (response.statusCode == 400) {
        message = 'Ministério já cadastrado';
      }
      if (response.statusCode == 500) {
        message = 'Erro ao salvar ministério';
      }
      throw RestClientException(message);
    }
    return response.body;
  }

  Future<MinisterioModel> atualizarMinisterio(
      int id, String ministerio, int lider, UserModel user) async {
    String tokenRequest = 'Bearer ' + user.token;
    final response = await restClient.put(
      '/ministerio/',
      {
        'id': id,
        'nome': ministerio,
        'user': lider,
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
      String message = 'Erro ao salvar ministério ';

      if (response.statusCode == 400) {
        message = 'Ministério já cadastrado';
      }
      if (response.statusCode == 500) {
        message = 'Erro ao salvar ministério';
      }
      if (response.statusCode == 404) {
        message = 'Ministerio não existe';
      }
      throw RestClientException(message);
    }
    return response.body;
  }

  Future<MinisterioModel> deletarMinisterio(int id, UserModel user) async {
    String tokenRequest = 'Bearer ' + user.token;
    final response = await restClient.delete(
      '/ministerio/$id',
      headers: {'Authorization': tokenRequest},
      decoder: (resp) {
        if (resp != '') {
          return null;
        }
      },
    );
    if (response.hasError) {
      print(response.request);
      String message = 'Erro ao deletar ministério ';

      if (response.statusCode == 400) {
        message = 'Erro';
      }
      if (response.statusCode == 500) {
        message = 'Erro ao deletar ministério';
      }
      if (response.statusCode == 404) {
        message = 'Ministerio não existe';
      }
      throw RestClientException(message);
    }
    return response.body;
  }
}
