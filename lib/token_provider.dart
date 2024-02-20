import 'package:flutter/foundation.dart';

class TokenProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  int _userTokens = 100;

  bool get isLoggedIn => _isLoggedIn;
  int get userTokens => _userTokens;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void updateUserTokens(int tokens) {
    _userTokens = tokens;
    notifyListeners();
  }

  void incrementUserTokens(int amount) {
    _userTokens += amount;
    notifyListeners();
  }
}
