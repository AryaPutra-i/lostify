import 'package:flutter/material.dart';
import '../../models/user_model.dart';

class RegisterController extends ChangeNotifier {
  bool isLoading = false;

  // simulasi register
  Future<bool> register(String username, String email) async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    // trim input
    username = username.trim();
    email = email.trim();

    // validasi email harus berakhir dengan @student.uisi.ac.id
    if (!email.endsWith('@student.uisi.ac.id')) {
      isLoading = false;
      notifyListeners();
      return false;
    }

    // cek apakah email sudah terdaftar
    bool emailExists = UserModel.registeredUsers.any(
      (user) => user.email == email,
    );
    if (emailExists) {
      isLoading = false;
      notifyListeners();
      return false;
    }

    // tambahkan user baru
    UserModel newUser = UserModel(
      id: UserModel.registeredUsers.length + 1,
      username: username,
      email: email,
    );
    UserModel.registeredUsers.add(newUser);

    isLoading = false;
    notifyListeners();
    return true;
  }
}
