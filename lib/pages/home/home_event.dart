
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class HomeSlideMenuEvent extends HomeEvent{

  // false 是关闭，true 是需要打开
   bool menuState = false;

   HomeSlideMenuEvent({required this.menuState});

  @override
  List<Object?> get props => [menuState];
}
