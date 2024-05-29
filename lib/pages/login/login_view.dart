import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website_nav/base/config.dart';
import 'package:website_nav/generated/l10n.dart';
import 'package:website_nav/pages/login/login_cubit.dart';
import 'package:website_nav/widgets/custom_widget.dart';
import 'package:website_nav/widgets/edit_widget.dart';

import 'login_state.dart';

class LoginPage extends StatelessWidget {
  LoginCubit? loginCibit;
  bool _loginLoading = false;
  String email = "";
  String password = "";
  String msg = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        loginCibit = context.read<LoginCubit>();
        if (state is LoginInitState) {
        } else if (state is LoginLoadingState) {
          _loginLoading = true;
        } else if (state is LoginSuccessState) {
          _loginLoading = false;
          msg = state.successMsg;
        } else if (state is LoginFailState) {
          _loginLoading = false;
          msg = state.failMsg;
          loginCibit?.resetView();
        } else if (state is LoginUserSuccessState) {
          _loginLoading = false;
          msg = state.successMsg;
          Config.localUserData = state.userBean;
          Navigator.pop(context);
        } else if (state is LoginDismissMsgState) {
          msg = "";
        }
        return _buildPage(context);
      },
    );
  }

  Widget _buildPage(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
          width: 200.w,
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: Colors.black)),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 5.h),
                  textWidget(
                    text: "${S.of(context).login}",
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  h(10.h),
                  customTextField(
                      hintText: "${S.of(context).user_email}",
                      controller: TextEditingController(text: email),
                      onChanged: (value) {
                        email = value;
                      }),
                  h(10.h),
                  customTextField(
                      hintText: "${S.of(context).password}",
                      controller: TextEditingController(text: email),
                      onChanged: (value) {
                        password = value;
                      }),
                  h(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            loginCibit?.loginUser(map: {"user_email": email, "password": password, "type": "login"});
                          },
                          child: Text("${S.of(context).login}")),
                      ElevatedButton(
                          onPressed: () {
                            loginCibit?.loginUser(map: {"user_email": email, "password": password, "user_type": 2, "type": "reg"});
                          },
                          child: Text("${S.of(context).reg}")),
                    ],
                  ),
                  AnimatedOpacity(
                    duration: Duration(seconds: 2),
                    opacity: (msg != '') ? 1 : 0,
                    child: textWidget(text: msg, textStyle: TextStyle(color: Colors.red, fontSize: 14)),
                  ),
                  h(10),
                ],
              ),
              Positioned(
                child: Center(
                  child: (_loginLoading) ? CircularProgressIndicator() : SizedBox(),
                ),
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
              )
            ],
          ),
        ));
  }
}
