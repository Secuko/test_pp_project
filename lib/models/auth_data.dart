class AuthData {
  String error;
  bool isAuthorized;

  AuthData({
    required this.error,
    required this.isAuthorized
  });


  AuthData copyWith({
    String? error,
    bool? isAuthorized,
  }) {
    return AuthData(
      error: error ?? this.error,
      isAuthorized: isAuthorized ?? this.isAuthorized,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AuthData &&
      other.error == error &&
      other.isAuthorized == isAuthorized;
  }

  @override
  int get hashCode => error.hashCode ^ isAuthorized.hashCode;

  @override
  String toString() => 'AuthData(error: $error, isAuthorized: $isAuthorized)';
}
