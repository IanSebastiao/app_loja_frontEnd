import 'package:app_loja/data/repository/user_repository.dart';
import 'package:flutter/material.dart';

class UserViewmodel with ChangeNotifier {
  final UserRepository _userRepository;

  String? _token;
  String? _username;
  String? _errorMessage;
  bool _isLoading = false;

  UserViewmodel(this._userRepository);

  String? get token => _token;
  String? get username => _username;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _token != null;

  Future<bool> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      _errorMessage = 'Por favor, preencha todos os campos';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _token = await _userRepository.login(username, password);
      _username = username;
      notifyListeners();
      return true;
    } on Exception catch (e) {
      _token = null;
      _username = null;
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
