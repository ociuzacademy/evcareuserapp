
class UserRegisterModel {
  final int id;
  final String name;
  final String username;
  final String phone;
  final String email;
  final String password;
  final String? image;

  UserRegisterModel({
    required this.id,
    required this.name,
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
    this.image, // image is nullable
  });

  // Factory constructor to create a UserModel from a JSON map
  factory UserRegisterModel.fromJson(Map<String, dynamic> json) {
    return UserRegisterModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
      image: json['image'], // Nullable, so it might be null
    );
  }

  // Method to convert a UserModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'phone': phone,
      'email': email,
      'password': password,
      'image': image,
    };
  }
}
