import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/generated/l10n.dart';
import 'package:website_nav/pages/home/bloc/click_cubit.dart';
import 'package:website_nav/pages/home/home_bloc.dart';
import 'package:website_nav/pages/home/home_event.dart';
import 'package:website_nav/pages/home/view/content_page.dart';
import 'package:website_nav/pages/home/view/top_page.dart';
import 'package:website_nav/pages/label/label_view.dart';
import 'package:website_nav/utils/print_utils.dart';

import '../home_state.dart';

class HomePage extends StatelessWidget {
  bool menuState = true;
  double width = 200;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 修改标题
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: '${S.of(context).knowledge}',
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ClickCubit()),
        BlocProvider(create: (context) => HomeBloc()),
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, state) {
          if (state is HomeInitialState) {
            printWhite("首頁");
          } else {}
          var name = S.of(context).name;
          return _buildUI(context);
        },
      ),
    );
  }

  Widget _buildUI(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            // 上方菜单
            TopPage(),
            SizedBox(
              height: 1,
              width: double.maxFinite,
              child: Container(
                color: Colors.black,
              ),
            ),
            // 下方
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  // 左侧
                  sideMenuWidget(context),
                  SizedBox(
                    height: double.maxFinite,
                    width: 1,
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                  // 右侧
                  Expanded(child: bodyContent())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 左侧菜单
  Widget sideMenuWidget(BuildContext context) {
    //侧边菜单
    return LabelPage(
      itemClick: (data) {
        context.read<ClickCubit>().moveToPosition(data);
      },
    );
  }

  // 右侧内容显示
  Widget bodyContent() {
    return ContentPage();
  }
}
