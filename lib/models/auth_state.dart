import 'package:test_pp_project/models/models.dart';

class AuthState {
  final AuthData authData;
  AuthState({
    required this.authData,
  });

  AuthState copyWith({
    AuthData? authData,
  }) {
    return AuthState(
      authData: authData ?? this.authData,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState && other.authData == authData;
  }

  @override
  int get hashCode => authData.hashCode;

  @override
  String toString() => 'AuthState(authData: $authData)';
}