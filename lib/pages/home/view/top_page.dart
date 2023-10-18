import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/bean/user_bean.dart';
import 'package:website_nav/generated/l10n.dart';
import 'package:website_nav/helper/app_shared_pref.dart';
import 'package:website_nav/pages/dialog/dialog_widgets.dart';
import 'package:website_nav/pages/home/home_bloc.dart';
import 'package:website_nav/pages/home/home_event.dart';
import 'package:website_nav/pages/login/login_bloc.dart';
import 'package:website_nav/pages/login/login_event.dart';
import 'package:website_nav/pages/login/login_state.dart';
import 'package:website_nav/utils/date_tool.dart';
import 'package:website_nav/utils/print_utils.dart';
import 'package:website_nav/utils/snack_bar_utils.dart';
import 'package:website_nav/utils/sp_utils.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  UserBean? userData;
  LoginBloc? loginBloc;
  GlobalKey languageKey = GlobalKey();
  Offset languageOffset = Offset.zero;

  Color selectColor = Colors.black;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<LoginBloc>().add(LoginUserLoadEvent(map: {}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (BuildContext context, state) {
        loginBloc = context.read<LoginBloc>();
        if (state is LoginUserSuccessState) {
          userData = state.userBean;
        } else if (state is LoginUserSuccessState) {
          userData = state.userBean;
        } else if (state is LoginUserLoadState) {
          userData = state.userBean;
        } else if (state is LoginUserLogOutState) {
          removeDataAll();
          userData = null;
        }

        return Container(
          height: 100,
          child: Row(
            children: [
              SizedBox(
                width: 6,
              ),
              // 老树昏鸦
              Text(
                "老树昏鸦",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Spacer(),

              // 知识导航  枯木 deadwood  逢春

              // 知识新增页面
              InkWell(
                onTap: () {
                  showSnackBar(msg: "新增");
                },
                child: Text(
                  "添加数据",
                  style: TextStyle(color: selectColor),
                ),
              ),

              // 外链接

              // 用户数据
              Container(
                padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.white, width: 2)),
                child: Row(
                  children: [
                    if (userData != null) Text("${userData?.name.toString()}"),
                    if (userData == null)
                      InkWell(
                        onTap: () {
                          // 弹框授权登录
                          showLogin(context: context);
                        },
                        child: Text("${S.of(context).login}"),
                      ),
                    SizedBox(
                      width: 10,
                    ),
                    if (userData != null)
                      InkWell(
                        onTap: () {
                          loginBloc?.add(LoginUserLogOutEvent(map: {}));
                        },
                        child: Text("${S.of(context).log_out}"),
                      ),
                  ],
                ),
              ),
              SizedBox(
                width: 6,
              ),
              // 语言切换
              InkWell(
                key: languageKey,
                onTap: () {
                  RenderObject? boundary = languageKey.currentContext!.findRenderObject();
                  Rect rect = boundary!.paintBounds;
                  showLanguageSelect(
                      context: context,
                      rect: rect,
                      selectLanguage: (LanguageValue) {
                        // 重新刷新页面
                        context.read<HomeBloc>().add(HomeInitEvent(randomValue: DateTool.timestamp()));
                        S.load(Locale(LanguageValue.languageCode.toString()));
                      });
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.language,
                      size: 20,
                      color: Colors.blue,
                    ),
                    Text(
                      "语言切换",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 6,
              ),
            ],
          ),
        );
      },
    );
  }
}
