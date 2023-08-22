import 'package:flutter/material.dart';
import 'package:test_pp_project/bloc/blocs.dart';
import 'package:test_pp_project/utils/utils.dart';
import 'package:test_pp_project/widgets/widgets.dart';
import 'package:test_pp_project/models/models.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key, required this.authBloc});

  final AuthCubit authBloc;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController loginTextController;
  late TextEditingController passwordTextController;

  @override
  void initState() {
    super.initState();
    //widget.authBloc.cleanError();
    loginTextController = TextEditingController(text: 'helloworld@mail.ru');
    passwordTextController = TextEditingController(text: 'adfghA123');
  }

  @override
  void dispose() {
    loginTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = widget.authBloc;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: screenWidth,
                height: screenHeight,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: AppColors.whiteGrey,
                ),
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      const HeadText('Registration'),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 32,
                        ),
                        height: 285,
                        width: 280,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.blue,
                          border: Border.all(
                            width: 1,
                            color: AppColors.black,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InputElem('E-mail', loginTextController),
                            InputElem('Password', passwordTextController),
                            StreamBuilder<AuthState>(
                                initialData: bloc.state,
                                stream: bloc.stream,
                                builder: (context, snapshot) {
                                  final str =
                                      snapshot.requireData.authData.error;
                                  return Text(str);
                                }),
                            GestureDetector(
                              onTap: () => {
                                bloc
                                    .registration(
                                      loginTextController.text,
                                      passwordTextController.text,
                                    )
                                    .then((value) =>
                                        (bloc.state.authData.isAuthorized)
                                            ? Navigator.of(context).pop()
                                            : null),
                              },
                              child: const BottomButton('Register'),
                            ),
                            GestureDetector(
                              onTap: () => {
                                bloc.cleanError().then(
                                    (value) => Navigator.of(context).pop())
                              },
                              child: const SizedBox(
                                height: 20,
                                child: TextUnderInputField(
                                    'Already have an account?'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
