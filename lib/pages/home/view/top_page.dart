import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/bean/user_bean.dart';
import 'package:website_nav/generated/l10n.dart';
import 'package:website_nav/navigations/root_route.dart';
import 'package:website_nav/pages/dialog/dialog_widgets.dart';
import 'package:website_nav/pages/home/home_bloc.dart';
import 'package:website_nav/pages/home/home_event.dart';
import 'package:website_nav/pages/knowledge_edit/knowledge_view.dart';
import 'package:website_nav/pages/login/login_cubit.dart';
import 'package:website_nav/pages/login/login_state.dart';
import 'package:website_nav/utils/date_tool.dart';
import 'package:website_nav/utils/sp_utils.dart';
// import 'dart:html' deferred as html;
import 'dart:html' as html;


class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {

  UserBean? userData;
  LoginCubit? loginBloc;
  GlobalKey languageKey = GlobalKey();
  Offset languageOffset = Offset.zero;

  Color selectColor = Colors.black;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<LoginCubit>().loadUser();
    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (BuildContext context, state) {
        loginBloc = context.read<LoginCubit>();
        if (state is LoginUserSuccessState) {
          userData = state.userBean;
        }  else if (state is LoginUserLoadState) {
          userData = state.userBean;
        } else if (state is LoginUserLogOutState) {
          removeDataAll();
          userData = null;
        }
        return Container(
          height: 60,
          child: Row(
            children: [
              SizedBox(
                width: 6,
              ),
              Text(
                "",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              Spacer(),
              // 意见反馈
              InkWell(
                onTap: () {
                  String url = "http://${html.window.location.host}/feedback";
                  html.window.open(url,"_blank");
                },
                child: Text(
                  "${S.of(context).feedback}",
                  style: TextStyle(color: selectColor),
                ),
              ),
              SizedBox(
                width: 6,
              ),
              // 知识新增页面
              InkWell(
                onTap: () {
                  if(userData==null){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("请先登录")));
                    return;
                  }
                  // String url = "http://${html.window.location.host}/add_data";
                  // html.window.open(url,"_blank");

                  // RootRouter().pushUrl(url: "add_data");

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return KnowledgePage();
                  }));
                },
                child: Text(
                  "${S.of(context).edit_data}",
                  style: TextStyle(color: selectColor),
                ),
              ),
              // 用户数据
              Container(
                padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.white, width: 2)),
                child: Row(
                  children: [
                    if (userData != null) Text("${userData?.userName ?? userData?.userEmail}"),
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
                          loginBloc?.logOut();
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
                      size: 16,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${S.of(context).language_select}",
                      style: TextStyle(fontSize: 16),
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
