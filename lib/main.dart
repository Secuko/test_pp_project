import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_pp_project/app_shell.dart';
import 'package:test_pp_project/bloc/auth_bloc.dart';
import 'package:test_pp_project/bloc/session_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          Provider<SessionCubit>(
            create: (_) => SessionCubit(),
          ),
          Provider<AuthCubit>(
            create: (_) => AuthCubit(),
            dispose: (context, value) {
              value.close();
            },
          ),
        ],
        child: const Scaffold(
          body: Center(
            child: AppShell(),
          ),
        ),
      ),
    );
  }
}
