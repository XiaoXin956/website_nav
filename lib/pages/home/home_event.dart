
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class HomeInitEvent extends HomeEvent{


  HomeInitEvent();
}

class HomeGetTypeDataEvent extends HomeEvent{

  final dynamic data;

  HomeGetTypeDataEvent({required this.data});

  @override
  List<Object?> get props => [data];

}


