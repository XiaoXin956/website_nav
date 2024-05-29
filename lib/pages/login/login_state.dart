import 'package:equatable/equatable.dart';
import 'package:website_nav/bean/user_bean.dart';

class LoginState extends Equatable{
  @override
  List<Object?> get props => [];
}


class LoginInitState extends LoginState{

}


class LoginLoadingState extends LoginState{}

// 登录成功
class LoginUserSuccessState extends LoginState{

  final String successMsg;

  final UserBean userBean;

  LoginUserSuccessState({required this.successMsg, required this.userBean});

  @override
  List<Object?> get props => [successMsg,userBean];
}
// 加载本地
class LoginUserLoadState extends LoginState{


  final UserBean? userBean;

  LoginUserLoadState({required this.userBean});

  @override
  List<Object?> get props => [userBean];
}

class LoginSuccessState extends LoginState{
  final String successMsg;

  LoginSuccessState({required this.successMsg});

  @override
  List<Object?> get props => [successMsg];
}

class LoginFailState extends LoginState{
  final String failMsg;

  LoginFailState({required this.failMsg});

  @override
  List<Object?> get props => [failMsg];
}


class LoginUserLogOutState extends LoginState{

  LoginUserLogOutState();

}


class LoginDismissMsgState extends LoginState{

  LoginDismissMsgState();

}
