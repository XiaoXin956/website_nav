import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/pages/home/home_bloc.dart';
import 'package:website_nav/pages/home/home_event.dart';
import 'package:website_nav/pages/home/view/slide_menu_view.dart';

import '../home_state.dart';

class HomePage extends StatelessWidget {
  bool menuState = true;
  double width = 200;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, state) {
        if (state is HomeInitialState) {
        } else {}

        return _buildUI(context);
      },
    );
  }

  Widget _buildUI(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.brown,
        child: Column(
          children: [
            // 上方菜单
            Container(
              height: 100,
              color: Colors.blue,
            ),
            // 下方
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  // 左侧
                  sideMenuWidget(context),
                  // 右侧
                  Container(
                    color: Colors.red,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget sideMenuWidget(BuildContext context) {
    //侧边菜单
    return SlideMenuView(
      itemClick: (data) {},
    );
  }
}
