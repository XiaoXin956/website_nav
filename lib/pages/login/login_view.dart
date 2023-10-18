import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/base/config.dart';
import 'package:website_nav/generated/l10n.dart';
import 'package:website_nav/utils/snack_bar_utils.dart';

import 'login_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginPage extends StatelessWidget {

  LoginBloc? loginBloc;
  bool _loginLoading = false;
  String email = "";
  String password = "";
  String msg= "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        loginBloc = BlocProvider.of<LoginBloc>(context);
        if (state is LoginInitState) {

        } else if (state is LoginLoadingState) {
          _loginLoading = true;
        } else if (state is LoginSuccessState) {
          _loginLoading = false;
          msg = state.successMsg;
        } else if (state is LoginFailState) {
          _loginLoading = false;
          msg = state.failMsg;
        } else if (state is LoginUserSuccessState) {
          _loginLoading = false;
          msg = state.successMsg;
          Config.localUserData = state.userBean;

          Navigator.pop(context);
        }
        return _buildPage(context);
      },
    );
  }

  Widget _buildPage(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(5),
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text("登录"),
            SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Expanded(child: Text("${S.of(context).user_name}")),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    flex: 4,
                    child: TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      enabled: !_loginLoading,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.orangeAccent, width: 1),
                          )),
                    ))
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Expanded(child: Text("${S.of(context).password}")),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 4,
                  child: TextField(
                    enabled: !_loginLoading,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.orangeAccent, width: 1),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            (_loginLoading)
                ? CircularProgressIndicator()
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      loginBloc?.add(LoginUserLoginEvent(map: {"email": email, "password": password,"type":"login"}));
                    },
                    child: Text("${S.of(context).login}")),
                ElevatedButton(
                    onPressed: () {
                      loginBloc?.add(LoginUserLoginEvent(map: {"email": email, "password": password,"type":"reg"}));
                    },
                    child: Text("${S.of(context).reg}")),
              ],
            ),

            if(msg!='')
              Text(msg),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }



}
