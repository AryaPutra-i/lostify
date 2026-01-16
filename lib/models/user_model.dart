class UserModel {
  final int id;
  final String name;
  final String email;

  // constructor
  UserModel({required this.id, required this.name, required this.email});

  // ambil data dari JSON (API / Database)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      name: json['name'] ?? json['username'] ?? '',
      email: json['email'] ?? '',
    );
  }

  // ubah object jadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
