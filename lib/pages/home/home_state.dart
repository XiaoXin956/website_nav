import 'package:equatable/equatable.dart';

import '../../bean/type_bean.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeTypeLoadingState extends HomeState {

  HomeTypeLoadingState();

}

class HomeTypeDataSuccessState extends HomeState {
  final List<TypeBean> typeData;

  HomeTypeDataSuccessState({required this.typeData});

  @override
  List<Object?> get props => [typeData.map((e) => e.id).toList()];
}


class HomeTypeDataFailState extends HomeState {
  final String msg;

  HomeTypeDataFailState({required this.msg});

  @override
  List<Object?> get props => [msg];
}


class HomeFailState extends HomeState {
  final String msg;

  HomeFailState({required this.msg});

  @override
  List<Object?> get props => [msg];
}


