import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class LoginController extends ChangeNotifier {
  bool isLoading = false;
  UserModel? user;
  String? errorMessage;
  
  final AuthService _authService = AuthService();

  // Login dengan Email dan Password
  Future<bool> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // Trim input
      email = email.trim();
      password = password.trim();

      // Validasi email harus berakhir dengan @student.uisi.ac.id
      if (!email.endsWith('@student.uisi.ac.id')) {
        errorMessage = 'Gunakan email @student.uisi.ac.id';
        isLoading = false;
        notifyListeners();
        return false;
      }

      // Validasi input tidak kosong
      if (email.isEmpty || password.isEmpty) {
        errorMessage = 'Email dan password harus diisi';
        isLoading = false;
        notifyListeners();
        return false;
      }

      // Panggil API login
      final result = await _authService.login(email, password);
      
      if (result['success'] == true) {
        user = result['user'];
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
      print('Error during login: $e');
      errorMessage = 'Terjadi kesalahan. Coba lagi.';
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Login dengan Google
  Future<Map<String, dynamic>> loginWithGoogle() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await _authService.loginWithGoogle();
      
      if (result['success'] == true) {
        user = result['user'];
      } else {
        errorMessage = result['message'];
      }
      
      isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      print('Error during Google login: $e');
      errorMessage = 'Terjadi kesalahan. Coba lagi.';
      isLoading = false;
      notifyListeners();
      return {
        'success': false,
        'message': errorMessage,
      };
    }
  }

  // Cek status login
  Future<bool> checkLoginStatus() async {
    return await _authService.isLoggedIn();
  }

  // Logout
  Future<void> logout() async {
    await _authService.logout();
    user = null;
    notifyListeners();
  }
}
