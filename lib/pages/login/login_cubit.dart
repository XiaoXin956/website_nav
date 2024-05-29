import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/helper/app_shared_pref.dart';
import 'package:website_nav/pages/login/login_state.dart';
import 'package:website_nav/repository/user_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  UserRepository userRepository;

  LoginCubit(this.userRepository) : super(LoginInitState());

  // 登录/注册
  loginUser({required Map<String, dynamic> map}) async {
    emit(LoginLoadingState());
    var userResult;
    if (map['type'] == "login") {
      userResult = await userRepository.userLogin(map);
    } else {
      userResult = await userRepository.userReg(map);
    }
    if (userResult.code == 0) {
      emit(LoginUserSuccessState(successMsg: "${userResult.msg}", userBean: userResult.data));
    } else {
      emit(LoginFailState(failMsg: "${userResult.msg}"));
    }
  }

  // 加载本地
  loadUser() async {
    emit(LoginUserLoadState(userBean: await AppSharedPref().getUserModel()));
  }

  // 退出登录
  logOut() async {
    AppSharedPref().clearUserModel();
    emit(LoginUserLogOutState());
  }

  resetView() {
    Future.delayed(Duration(milliseconds: 2000), () {
      emit(LoginDismissMsgState());
    });
  }
}
