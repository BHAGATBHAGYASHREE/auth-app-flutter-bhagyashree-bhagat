class User {
  String id;
  String name;
  String username;
  String email;
  String password;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['_id'],
      name: map['name'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
