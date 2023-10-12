
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class HomeInitEvent extends HomeEvent{


  HomeInitEvent();
}

class HomeGetTypeDataEvent extends HomeEvent{


  HomeGetTypeDataEvent();

}


