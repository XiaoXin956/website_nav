
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/helper/app_shared_pref.dart';
import 'package:website_nav/repository/user_repository.dart';
import 'package:website_nav/utils/sp_utils.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  UserRepository userRepository= UserRepository();

  LoginBloc() : super(LoginState()) {
    on<LoginInitEvent>((event, emit){
      emit(LoginInitState());
    });
    on<LoginUserLoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      var userResult;
      if(event.map['type']=="login"){
        userResult = await userRepository.userLogin(event.map);
      }else{
        userResult = await userRepository.userReg(event.map);
      }
      if(userResult.code==0){
        emit(LoginUserSuccessState(successMsg:"${userResult.msg}", userBean: userResult.data));
      }else{
        emit(LoginFailState(failMsg: "${userResult.msg}"));
      }
    });
    // 加载本地
    on<LoginUserLoadEvent>((event, emit) async {
      emit(LoginUserLoadState(userBean: await AppSharedPref().getUserModel()));
    });
    on<LoginUserLogOutEvent>((event, emit) async {
        emit(LoginUserLogOutState());
    });
  }


}
