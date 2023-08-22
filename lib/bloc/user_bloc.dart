import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_pp_project/bloc/blocs.dart';
import 'package:test_pp_project/data_access/user_data_provider.dart';
import 'dart:async';
import 'package:test_pp_project/models/models.dart';

class USerCubit extends Cubit<UserState>{
  final _userDataProvider = UserDataProvider();
  USerCubit() : super(UserState(user: User(login: '', password: ''))) {
    _initialize();
  }

  Future<void> deleteAccount(AuthCubit authState) async {
    await _userDataProvider.saveValue(User(login: '', password: ''));
    emit(UserState(user: User(login: '', password: '')));
    await authState.logout();
    print('delete account');
  }

  Future<void> _initialize() async {
    final user = await _userDataProvider.loadValue();
    final newState = state.copyWith(user: user);
    emit(newState);
  }
}
