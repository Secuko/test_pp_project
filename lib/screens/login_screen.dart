import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pp_project/bloc/blocs.dart';
import 'package:test_pp_project/screens/registration_screen.dart';
import 'package:test_pp_project/utils/utils.dart';
import 'package:test_pp_project/widgets/widgets.dart';
import 'package:test_pp_project/models/models.dart';

class ScreenLoginWindow extends StatefulWidget {
  const ScreenLoginWindow({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ScreenLoginWindowState();
  }
}

class ScreenLoginWindowState extends State<ScreenLoginWindow> {
  late TextEditingController loginTextController;
  late TextEditingController passwordTextController;

  @override
  void initState() {
    super.initState();
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
    final bloc = context.read<AuthCubit>();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      //appBar: const CustomAppBar( color: AppColors.black),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                        const HeadText('Authorization'),
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
                              InputElem('Пароль', passwordTextController),
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
                                      .login(
                                        loginTextController.text,
                                        passwordTextController.text,
                                      )
                                      .then((value) =>
                                          print('${bloc.hashCode} in login')),
                                },
                                child: const BottomButton('Log in'),
                              ),
                              GestureDetector(
                                onTap: () => {
                                  bloc.cleanError().then(
                                        (value) =>
                                            Navigator.of(context).push<Widget>(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              bloc.cleanError;
                                              return RegistrationScreen(
                                                  authBloc: bloc);
                                            },
                                          ),
                                        ),
                                      ),
                                },
                                child: const SizedBox(
                                  height: 20,
                                  child: TextUnderInputField('Create account'),
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
      ),
    );
  }
}

// Navigator.of(context).push<Widget>(
//                                       MaterialPageRoute(
//                                         builder: (BuildContext context) {
//                                           return const ScreenRegistrationContinue();
//                                         },
//                                       ),
//                                     )

