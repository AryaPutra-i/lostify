import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  // Ganti URL ini dengan URL server PHP Anda
  // Untuk testing lokal dengan XAMPP: http://localhost/lostify/databasephp
  // Untuk emulator Android: http://10.0.2.2/lostify/databasephp
  // Untuk device fisik: gunakan IP komputer Anda
  // Menggunakan port 8000 yang baru saja kita jalankan
  static const String baseUrl = 'http://localhost/lostify/';
  
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  // Login dengan Email dan Password
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login.php'),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['success'] == true) {
          _currentUser = UserModel.fromJson(data['user']);
          await _saveUserToPrefs(_currentUser!);
          return {
            'success': true,
            'message': 'Login berhasil',
            'user': _currentUser,
          };
        } else {
          return {
            'success': false,
            'message': 'Email atau password salah',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Gagal terhubung ke server',
        };
      }
    } catch (e) {
      print('Login error: $e');
      return {
        'success': false,
        // 'message': 'Error: Tidak dapat terhubung ke server. Pastikan server PHP berjalan.',
        'message': '$e',
      };
    }
  }

  // Register akun baru
  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register.php'),
        body: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['success'] == true) {
          return {
            'success': true,
            'message': 'Registrasi berhasil! Silakan login.',
          };
        } else {
          return {
            'success': false,
            'message': data['message'] ?? 'Registrasi gagal. Email mungkin sudah terdaftar.',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Gagal terhubung ke server',
        };
      }
    } catch (e) {
      print('Register error: $e');
      return {
        'success': false,
        'message': 'Error: Tidak dapat terhubung ke server. Pastikan server PHP berjalan.',
      };
    }
  }

  // Login dengan Google (simulasi - untuk implementasi nyata perlu firebase_auth)
  Future<Map<String, dynamic>> loginWithGoogle() async {
    // Untuk implementasi Google Sign-In yang sebenarnya, Anda perlu:
    // 1. Menambahkan package google_sign_in
    // 2. Konfigurasi di Google Cloud Console
    // 3. Konfigurasi di Firebase (opsional tapi recommended)
    
    // Saat ini mengembalikan pesan bahwa fitur belum tersedia
    return {
      'success': false,
      'message': 'Fitur Google Sign-In memerlukan konfigurasi tambahan. Silakan gunakan login dengan email.',
    };
  }

  // Logout
  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_name');
    await prefs.remove('user_email');
  }

  // Cek apakah sudah login
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    
    if (userId != null) {
      _currentUser = UserModel(
        id: userId,
        name: prefs.getString('user_name') ?? '',
        email: prefs.getString('user_email') ?? '',
      );
      return true;
    }
    return false;
  }

  // Simpan user ke SharedPreferences
  Future<void> _saveUserToPrefs(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', user.id);
    await prefs.setString('user_name', user.name);
    await prefs.setString('user_email', user.email);
  }
}
