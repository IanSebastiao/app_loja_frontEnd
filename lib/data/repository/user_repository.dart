import 'package:app_loja/services/api_services.dart';

class UserRepository {
  final ApiServices apiServices;

  UserRepository(this.apiServices);

  Future<String> login(String username, password) async {
    try {
      return await apiServices.login(username, password);
    } catch (e) {
      throw Exception('Erro ao tentar realizar o login $e');
    }
  }
}
