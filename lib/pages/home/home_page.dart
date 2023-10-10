
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/pages/home/home_bloc.dart';
import 'package:website_nav/pages/home/home_event.dart';

import 'home_state.dart';

class HomePage extends StatelessWidget {
  bool menuState = true;
  double width = 200;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, state) {
        if (state is HomMenuCloseState) {
          // 关闭
          menuState = false;
          width = 100;
        } else if (state is HomeMenuOpenState) {
          //打开
          menuState = true;
          width = 200;
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
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      child: Container(
        width: width,
        height: double.maxFinite,
        color: Colors.amber,
        child: Row(
          children: [
            Expanded(
                child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Text("1"),
                Text("1"),
                Text("1"),
                Text("1"),
                Text("1"),
                Text("1"),
                Text("1"),
                Text("1"),
                Text("1"),
              ],
            )),
            IconButton(
                onPressed: () {
                  context.read<HomeBloc>().add(HomeSlideMenuEvent(menuState: menuState));
                },
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 30,
                )),
          ],
        ),
      ),
    );

    return Container(
      width: (menuState) ? 200 : 100,
      height: double.maxFinite,
      color: Colors.amber,
      child: Row(
        children: [
          // ListView(
          //   padding: EdgeInsets.zero,
          //   children: [
          //     Text("1"),
          //     Text("1"),
          //     Text("1"),
          //     Text("1"),
          //     Text("1"),
          //     Text("1"),
          //     Text("1"),
          //     Text("1"),
          //     Text("1"),
          //   ],
          // ),
          IconButton(
              onPressed: () {
                context.read<HomeBloc>().add(HomeSlideMenuEvent(menuState: menuState));
              },
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 50,
              )),
        ],
      ),
    );
  }
}
