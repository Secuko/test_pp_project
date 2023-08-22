import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_pp_project/bloc/blocs.dart';
import 'package:test_pp_project/models/models.dart';
import 'package:test_pp_project/utils/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthCubit>();
    return StreamBuilder<AuthState>(
      initialData: bloc.state,
        stream: bloc.stream,
        builder: (context, snapshot) {
          final isAuthorized = snapshot.requireData.authData.isAuthorized;
          return AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: (isAuthorized) ? AppColors.white : AppColors.whiteGrey,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            toolbarHeight: 0,
          );
        });
  }

  @override
  Size get preferredSize => Size.zero;
}
