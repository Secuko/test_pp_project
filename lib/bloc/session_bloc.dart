import 'package:bloc/bloc.dart';
import 'package:test_pp_project/api/network.dart';
import 'package:test_pp_project/data_access/session_data_provider.dart';
import 'dart:async';
import 'package:test_pp_project/models/models.dart';

class SessionCubit extends Cubit<SessionState> {
  final _sessionDataProvider = SessionDataProvider();

  SessionCubit()
      : super(
          SessionState(
            session: Session(
                firstPlayerScoreHasChange: false,
                secondPlayerScoreHasChange: false,
                gameIsEnd: false,
                round: 0,
                showAnswer: false,
                questions: [],
                firstPlayerScore: 0,
                secondPlayerScore: 0,
                gameIsStart: true,
                currentPlayer: 1),
          ),
        ) {
    _initialize();
  }

  Future<void> _initialize() async {
    final session = await _sessionDataProvider.loadValue();
    final newState = state.copyWith(session: session);
    emit(newState);
  }

  Future<void> clearSessionData() async {
    final emptySession = Session.empty();
    _sessionDataProvider.saveValue(emptySession);
    emit(state.copyWith(session: emptySession));
  }

  Future<void> getNextQuestion() async {
    var session = state.session;
    if (session.round >= 9) {
      endGame();
      return;
    } else {
      session = session.copyWith(
          round: session.round + 1,
          showAnswer: false,
          secondPlayerScoreHasChange: false,
          firstPlayerScoreHasChange: false);
    }
    emit(state.copyWith(session: session));
  }

  void showAnswer() {
    var session = state.session;
    session = session.copyWith(showAnswer: true);
    emit(state.copyWith(session: session));
  }

  void hideAnswer() {
    var session = state.session;
    session = session.copyWith(showAnswer: false);
    emit(state.copyWith(session: session));
  }

  Future<void> startGame() async {
    var session = state.session;
    final questions = await randomQuestionRequest();
    if (questions != null) {
      session = session.copyWith(questions: questions);
      emit(state.copyWith(session: session));
    }
    session = session.copyWith(gameIsStart: true, gameIsEnd: false);
    await _sessionDataProvider.saveValue(session);
    emit(state.copyWith(session: session));
  }

  Future<void> endGame() async {
    var session = state.session;
    session = session.copyWith(gameIsEnd: true);
    await _sessionDataProvider.saveValue(session);
    emit(state.copyWith(session: session));
  }

  Future<void> restartGame() async {
    var session = state.session;
    session = session.copyWith(
        firstPlayerScoreHasChange: false,
        secondPlayerScoreHasChange: false,
        gameIsStart: false,
        gameIsEnd: false,
        round: 0,
        firstPlayerScore: 0,
        secondPlayerScore: 0,
        showAnswer: false);
    await _sessionDataProvider.saveValue(session);
    emit(state.copyWith(session: session));
  }

  void increasePlayerScore(int score, int playerIndex) {
    var session = state.session;
    int questionValue = session.questions[session.round].value;
    switch (playerIndex) {
      case 1:
        session = session.copyWith(
            firstPlayerScore: session.firstPlayerScore + questionValue,
            firstPlayerScoreHasChange: true);
        break;
      case 2:
        session = session.copyWith(
            secondPlayerScore: session.secondPlayerScore + questionValue,
            secondPlayerScoreHasChange: true);
        break;
    }
    emit(state.copyWith(session: session));
    changeCurrentPlayer();
  }

  void changeCurrentPlayer() {
    var session = state.session;
    switch (session.currentPlayer) {
      case 1:
        session = session.copyWith(currentPlayer: 2);
        break;
      case 2:
        session = session.copyWith(currentPlayer: 1);
        break;
    }
    emit(state.copyWith(session: session));
  }
}
