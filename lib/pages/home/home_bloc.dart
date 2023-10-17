import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/utils/print_utils.dart';

import '../../bean/result_bean.dart';
import '../../repository/type_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  TypeRepository typeRepository = TypeRepository();

  HomeBloc() : super(HomeInitialState()) {
    on<HomeEvent>((event, emit) {});
    on<HomeInitEvent>((event, emit) {
      printBlue("初始化");
      emit(HomeInitialState());
    });
    on<HomeGetTypeDataEvent>((event, emit) async {
      emit(HomeTypeLoadingState());
      ResultBean resultBean = await typeRepository.getSearchType(event.data);
      if (resultBean.code == 0) {
        emit(HomeTypeDataSuccessState(typeData: resultBean.data));
      } else {
        emit(HomeTypeDataFailState(msg: "${resultBean.msg}"));
      }
    });
  }
}
