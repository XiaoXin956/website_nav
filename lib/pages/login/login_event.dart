import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoginInitEvent extends LoginEvent {}

class LoginUserLoginEvent extends LoginEvent{

  final dynamic map;

  LoginUserLoginEvent({required this.map});

  @override
  List<Object?> get props => [map];
}


class LoginUserLogOutEvent extends LoginEvent{

  final dynamic map;

  LoginUserLogOutEvent({required this.map});

  @override
  List<Object?> get props => [map];
}


class LoginUserLoadEvent extends LoginEvent{

  final dynamic map;

  LoginUserLoadEvent({required this.map});

  @override
  List<Object?> get props => [map];
}
