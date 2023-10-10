import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeEvent>((event, emit) {

    });

    // 修改菜单打开缩小
    on<HomeSlideMenuEvent>((event, emit) {
      if(event.menuState){
        // 需要关闭
        emit(HomMenuCloseState());
      }else{
        // 需要打开
        emit(HomeMenuOpenState());
      }
    });

  }





}
