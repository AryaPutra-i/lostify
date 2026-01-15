import 'package:flutter/material.dart';
import '../models/user_model.dart';

class LoginController extends ChangeNotifier {
  bool isLoading = false;
  UserModel? user;

  // simulasi login (nanti bisa diganti API)
  Future<bool> login(String username, String email) async {
    isLoading = true;
    notifyListeners();

    // simulasi delay seperti request API
    await Future.delayed(const Duration(seconds: 2));

    // validasi email harus berakhir dengan @student.uisi.ac.id
    if (!email.endsWith('@student.uisi.ac.id')) {
      isLoading = false;
      notifyListeners();
      return false;
    }

    // logika sederhana (sementara)
    if (username.isNotEmpty && email.isNotEmpty) {
      user = UserModel(id: 1, username: username, email: email);

      isLoading = false;
      notifyListeners();
      return true;
    }

    isLoading = false;
    notifyListeners();
    return false;
  }

  void logout() {
    user = null;
    notifyListeners();
  }
}
