
import 'package:equatable/equatable.dart';
import 'package:website_nav/bean/type_bean.dart';

abstract class HomeEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class HomeInitEvent extends HomeEvent{

  final dynamic randomValue;

  HomeInitEvent({required this.randomValue});

  @override
  List<Object?> get props => [randomValue];

}

class HomeMoveToPositionEvent extends HomeEvent{

  final TypeBean typeBean;
  HomeMoveToPositionEvent({required this.typeBean});
  @override
  List<Object?> get props => [typeBean];

}

