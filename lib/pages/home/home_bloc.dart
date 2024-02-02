import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/utils/date_tool.dart';
import 'package:website_nav/utils/print_utils.dart';

import '../../bean/result_bean.dart';
import '../../repository/type_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(HomeInitialState(randomValue: DateTool.timestamp())) {
    on<HomeEvent>((event, emit) {});
    on<HomeInitEvent>((event, emit) {
      emit(HomeInitialState(randomValue: DateTool.timestamp()));
    });
    // // 滑动到指定位置
    // on<HomeMoveToPositionEvent>((event, emit){
    //   emit(HomeMoveToPositionState(typeBean: event.typeBean));
    // });

  }
}
