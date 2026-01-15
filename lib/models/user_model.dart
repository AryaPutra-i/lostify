class UserModel {
  final int id;
  final String username;
  final String email;

  // constructor
  UserModel({required this.id, required this.username, required this.email});

  // ambil data dari JSON (API / Database)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }

  // ubah object jadi JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'email': email};
  }
}
