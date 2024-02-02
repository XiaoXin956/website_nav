import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:website_nav/bean/type_bean.dart';

part 'click_state.dart';

class ClickCubit extends Cubit<ClickState> {
  ClickCubit() : super(ClickInitial());

  moveToPosition(TypeBean typeBean){
    emit(ClickMoveToPositionState(typeBean: typeBean));
  }

  clickInitial(){
    emit(ClickInitial());
  }

}
