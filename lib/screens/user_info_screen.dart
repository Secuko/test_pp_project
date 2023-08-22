import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pp_project/bloc/blocs.dart';
import 'package:test_pp_project/utils/utils.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = USerCubit();
    final authBloc = context.read<AuthCubit>();
    final sessionBloc = context.read<SessionCubit>();
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                height: 120,
                alignment: Alignment.centerLeft,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 1, color: AppColors.black)),
                child: StreamBuilder(
                  initialData: userBloc.state,
                  stream: userBloc.stream,
                  builder: (context, snapshot) {
                    final login = snapshot.requireData.user.login;
                    final password = snapshot.requireData.user.password;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AccountInfoData(
                          preText: 'E-mail',
                          value: login.toString(),
                        ),
                        AccountInfoData(
                          preText: 'Password',
                          value: password.toString(),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => authBloc.logout().then(
                      (value) => sessionBloc.clearSessionData(),
                    ),
                child: Container(
                  height: 45,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.neutralBlue,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(width: 1, color: AppColors.black),
                  ),
                  child: const Text(
                    'logout',
                    style: AppTypography.font16B,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => userBloc.deleteAccount(authBloc).then(
                      (value) => sessionBloc.clearSessionData(),
                    ),
                child: Container(
                  height: 45,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.errorRed,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(width: 1, color: AppColors.black),
                  ),
                  child: const Text(
                    'deleteAccount',
                    style: AppTypography.font16B,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountInfoData extends StatelessWidget {
  const AccountInfoData(
      {super.key, required this.preText, required this.value});
  final String preText;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text.rich(
          style: AppTypography.font20B,
          TextSpan(children: [
            TextSpan(
              text: '$preText: ',
            ),
            TextSpan(
              text: value,
              style: AppTypography.font20,
            ),
          ])),
    );
  }
}
