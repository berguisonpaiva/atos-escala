import 'package:escala/app/helpers/rest_client.dart';
import 'package:escala/app/models/user_model.dart';

class UserRepository {
  final RestClient restClient;

  UserRepository(this.restClient);

  Future<UserModel> login(String email, String password) async {
    final response = await restClient.post(
      '/user/auth',
      {'email': email, 'password': password},
      decoder: (resp) {
        if (resp != '') {
          return UserModel.fromMap(resp);
        }
      },
    );
    if (response.hasError) {
      String message = 'Erro ao autenticar usuário ';

      if (response.statusCode == 403) {
        message = 'Usuário e Senha Inválidos';
      }
      throw RestClientException(message);
    }
    return response.body;
  }

  Future<void> saveUser(model) async {
    final response = await restClient.post('/user/',
        {"name": model.name, "email": model.email, "password": model.password});

    if (response.hasError) {
      throw RestClientException('Erro ao registrar usuario');
    }
  }

  Future<List<UserModel>> findAll(String token) async {
    String tokenRequest = 'Bearer ' + token;
    final response = await restClient.get<List<UserModel>>('/user/',
        headers: {'Authorization': tokenRequest}, decoder: (resp) {
      if (resp is List) {
        return resp.map<UserModel>((ev) => UserModel.fromMap(ev)).toList();
      }
      return null;
    });
    if (response.hasError) {
      throw RestClientException('Erro ao buscar Ministerio');
    }
    return response.body;
  }
}
