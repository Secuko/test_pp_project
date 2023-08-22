import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pp_project/models/models.dart';
import 'package:test_pp_project/screens/api_screen.dart';
import 'package:test_pp_project/screens/login_screen.dart';
import 'package:test_pp_project/screens/user_info_screen.dart';
import 'package:test_pp_project/utils/utils.dart';
import 'package:test_pp_project/widgets/widgets.dart';

import 'bloc/auth_bloc.dart';

enum TabType { map, profile, operations, admin }

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      return;
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  List<Widget> _widgetOptions = [];
  List<BottomNavigationBarItem> _tabList = [];

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      const StartGameScreen(),
      const UserInfoScreen(),
    ];

    _tabList = [
      const BottomNavigationBarItem(
        backgroundColor: AppColors.black,
        icon: Icon(Icons.gamepad),
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: '',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthCubit>();
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: StreamBuilder<AuthState>(
          initialData: bloc.state,
          stream: bloc.stream,
          builder: (context, snapshot) {
            final isAuthorized = snapshot.requireData.authData.isAuthorized;
            // print(
            //     'appshell stream builder: current status login $isAuthorized');
            if (isAuthorized) {
              return _widgetOptions.elementAt(_selectedIndex);
            } else {
              return const ScreenLoginWindow();
            }
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder<AuthState>(
        initialData: bloc.state,
        stream: bloc.stream,
        builder: (context, snapshot) {
          final isAutorized = snapshot.requireData.authData.isAuthorized;
          if (isAutorized) {
            return SizedBox(
              height: 70,
              child: Container(
                color: AppColors.greenLight,
                child: Column(
                  children: [
                    BottomNavigationBar(
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      iconSize: 30,
                      backgroundColor: AppColors.greenLight,
                      type: BottomNavigationBarType.fixed,
                      landscapeLayout:
                          BottomNavigationBarLandscapeLayout.spread,
                      items: _tabList,
                      currentIndex: _selectedIndex,
                      selectedItemColor: AppColors.white,
                      unselectedItemColor: AppColors.black,
                      onTap: _onItemTapped,
                    ),
                    SizedBox(
                      height: 5,
                      child: Container(
                        color: AppColors.greenLight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _BottomBarUnderline(
                              index: 0,
                              selectedIndex: _selectedIndex,
                            ),
                            _BottomBarUnderline(
                              index: 1,
                              selectedIndex: _selectedIndex,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.square(
              dimension: 0,
            );
          }
        },
      ),
      //),
    );
  }
}

class _BottomBarUnderline extends StatelessWidget {
  const _BottomBarUnderline({
    required this.index,
    required this.selectedIndex,
  });

  final int index;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1),
        color: (index == selectedIndex)
            ? AppColors.whiteLight
            : Colors.transparent,
      ),
      width: screenWidth / 2 - 7,
    );
  }
}
