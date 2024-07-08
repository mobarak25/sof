class Login {
  final String username;
  final String password;

  const Login({
    required this.username,
    required this.password,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
