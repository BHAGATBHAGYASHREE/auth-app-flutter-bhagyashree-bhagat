  class User {
  final String? id;
  final String? name;
  final String username;
  final String email;
  final String password;

  User({ 
    this.id,
    this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) { //factory means kisi class ak obj create karega
    return User(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String? ?? '', 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    };
  }
}