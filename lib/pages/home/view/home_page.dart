import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/generated/l10n.dart';
import 'package:website_nav/pages/home/home_bloc.dart';
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
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: '${S.of(context).knowledge}',
      ),
    );
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, state) {
        if (state is HomeInitialState) {
          printWhite("首頁");
        } else {}

        var name = S.of(context).name;
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
            TopPage(),
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
    return LabelPage(
      itemClick: (data) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(
          padding: EdgeInsets.only(top: 20,bottom: 20),
          child: Text("当前选中${data["id"]}",style: TextStyle(color: Colors.red),),
        ),backgroundColor: Colors.white,));
      },
    );
  }
}
