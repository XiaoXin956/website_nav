part of 'click_cubit.dart';

@immutable
abstract class ClickState extends Equatable{
  @override
  List<Object?> get props => [];
}

class ClickInitial extends ClickState {}


class ClickMoveToPositionState extends ClickState{

  final TypeLabelBean typeBean;
  ClickMoveToPositionState({required this.typeBean});
  @override
  List<Object?> get props => [typeBean];
}