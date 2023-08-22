import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:test_pp_project/data_access/user_data_provider.dart';
import 'package:test_pp_project/data_access/auth_data_provider.dart';
import 'package:test_pp_project/models/models.dart';

import '../utils/utils.dart';

class AuthCubit extends Cubit<AuthState> {
  final _authDataProvider = AuthDataProvider();
  final _userDataProvider = UserDataProvider();

  AuthCubit()
      : super(AuthState(authData: AuthData(isAuthorized: false, error: ''))) {
    _initialize();
  }

  Future<void> _initialize() async {
    final authData = await _authDataProvider.loadValue();
    final newState = state.copyWith(authData: authData);
    emit(newState);
  }

  Future<void> login(String login, String password) async {
    final user = await _userDataProvider.loadValue();
    var authData = state.authData;
    if (user.login == login && user.password == password) {
      authData = authData.copyWith(isAuthorized: true, error: '');
    } else {
      authData = authData.copyWith(error: "Неверный логин или пароль");
    }
    final newState = state.copyWith(authData: authData);
    await _authDataProvider.saveValue(authData);
    emit(newState);
  }

  Future<void> registration(String login, String password) async {
    var authData = state.authData;
    if (await _dataValidation(login, password, false) != null) {
      authData =
          authData.copyWith(error: await _dataValidation(login, password));
    } else {
      await _userDataProvider.saveValue(User(login: login, password: password));
      authData = authData.copyWith(isAuthorized: true, error: '');
    }
    await _authDataProvider.saveValue(authData);
    emit(state.copyWith(authData: authData));
  }

  Future<void> cleanError() async {
    var authData = state.authData;
    authData = authData.copyWith(error: '');
    emit(state.copyWith(authData: authData));
  }

  Future<void> logout() async {
    var authData = state.authData;
    authData = authData.copyWith(isAuthorized: false, error: '');
    await _authDataProvider.saveValue(authData);
    emit(state.copyWith(authData: authData));
  }

  Future<String?> _dataValidation(String email, String password,
      [bool withoutCurrentCheck = true]) async {
    final regExpPassword = RegExp(Constants.passwordRegex);
    final regExpEmail = RegExp(Constants.emailRegex);
    final user = await _userDataProvider.loadValue();

    String? isEmptyFieldsValidator() {
      return (email.isEmpty | password.isEmpty)
          ? 'All fields should be filled in'
          : null;
    }

    String? passwordValidator() {
      return (regExpPassword.hasMatch(password.trim()))
          ? null
          : 'Password should have at least one upper case letter and one number';
    }

    String? emailValidator() {
      return (regExpEmail.hasMatch(email.trim()))
          ? null
          : 'Incorrect e-mail format';
    }

    String? checkOnEqualsWithCurrentData() {
      return (user.login == email) ? 'This e-mail already exists' : null;
    }

    if (isEmptyFieldsValidator() != null) {
      return isEmptyFieldsValidator();
    } else if (emailValidator() != null) {
      return emailValidator();
    } else if (passwordValidator() != null) {
      return passwordValidator();
    } else if (withoutCurrentCheck && checkOnEqualsWithCurrentData() != null) {
      return checkOnEqualsWithCurrentData();
    } else {
      return null;
    }
  }
}
