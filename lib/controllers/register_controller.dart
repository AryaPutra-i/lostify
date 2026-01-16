import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterController extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  
  final AuthService _authService = AuthService();

  // Register akun baru
  Future<bool> register(String name, String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // Trim input
      name = name.trim();
      email = email.trim();
      password = password.trim();

      // Validasi nama tidak kosong
      if (name.isEmpty) {
        errorMessage = 'Nama lengkap harus diisi';
        isLoading = false;
        notifyListeners();
        return false;
      }

      // Validasi email harus berakhir dengan @student.uisi.ac.id
      if (!email.endsWith('@student.uisi.ac.id')) {
        errorMessage = 'Gunakan email @student.uisi.ac.id';
        isLoading = false;
        notifyListeners();
        return false;
      }

      // Validasi password minimal 6 karakter
      if (password.length < 6) {
        errorMessage = 'Password minimal 6 karakter';
        isLoading = false;
        notifyListeners();
        return false;
      }

      // Panggil API register
      final result = await _authService.register(name, email, password);
      
      if (result['success'] == true) {
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        errorMessage = result['message'];
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('Error during register: $e');
      errorMessage = 'Terjadi kesalahan. Coba lagi.';
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
