import 'package:test_pp_project/models/models.dart';

class SessionState {
  final Session session;

  SessionState({
    required this.session,
  });

  SessionState copyWith({
    Session? session,
  }) {
    return SessionState(
      session: session ?? this.session,
    );
  }

  @override
  String toString() => 'SessionState(session: $session)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SessionState && other.session == session;
  }

  @override
  int get hashCode => session.hashCode;
}