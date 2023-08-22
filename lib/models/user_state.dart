import 'package:test_pp_project/models/models.dart';

class UserState {
  final User user;
  UserState({
    required this.user,
  });

  UserState copyWith({
    User? user,
  }) {
    return UserState(
      user: user ?? this.user,
    );
  }

  @override
  String toString() => 'UserState(user: $user)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserState && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}