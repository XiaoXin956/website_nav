
import 'package:equatable/equatable.dart';

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


