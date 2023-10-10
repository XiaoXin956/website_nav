import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {}

// 打开左侧菜单
class HomeMenuOpenState extends HomeState {}

// 关闭左侧菜单
class HomMenuCloseState extends HomeState {}
