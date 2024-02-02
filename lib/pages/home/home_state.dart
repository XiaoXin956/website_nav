import 'package:equatable/equatable.dart';
import 'package:website_nav/bean/type_bean.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {

  final dynamic randomValue;
  HomeInitialState({ required this.randomValue});
  @override
  List<Object?> get props => [randomValue];
}

class HomeFailState extends HomeState {
  final String msg;

  HomeFailState({required this.msg});

  @override
  List<Object?> get props => [msg];
}


