class User {
  String login;
  String password;
  User(
      {required this.login,
      required this.password,});

  User copyWith({
    String? login,
    String? password,
    bool? isAuthorized,
  }) {
    return User(
      login: login ?? this.login,
      password: password ?? this.password,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.login == login &&
        other.password == password;
  }

  @override
  int get hashCode =>
      login.hashCode ^ password.hashCode;

  @override
  String toString() =>
      'User(login: $login, password: $password)';
}
