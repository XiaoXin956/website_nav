import 'package:bloc/bloc.dart';
import 'package:website_nav/bean/result_bean.dart';
import 'package:website_nav/repository/type_repository.dart';
import 'package:website_nav/utils/print_utils.dart';

import 'label_event.dart';
import 'label_state.dart';

class LabelBloc extends Bloc<LabelEvent, LabelState> {
  TypeRepository typeRepository = TypeRepository();

  LabelBloc() : super(LabelTypeInitialState()) {
    on<LabelTypeInitialEvent>((event, emit) {
      printBlue("初始化");
      emit(LabelTypeInitialState());
    });
    on<LabelTypeEditEvent>((event, emit) {
      printBlue("编辑");
      emit(LabelTypeEditState(edit: event.edit));
    });
    on<LabelTypeAllSearchEvent>((event, emit) async {
      emit(LabelTypeLoadingState());
      ResultBean resultBean = await typeRepository.getSearchType(event.data);
      if (resultBean.code == 0) {
        emit(LabelTypeSearchSuccessState(typeData: resultBean.data));
      } else {
        emit(LabelTypeFailState(msgFail: "${resultBean.msg}"));
      }
    });
    // 删除
    on<LabelTypeDelEvent>((event, emit) async {
      ResultBean resultBean = await typeRepository.delType(event.data);
      if (resultBean.code == 0) {
        emit(LabelTypeSuccessState(msgSuccess: '删除成功'));
      } else {
        emit(LabelTypeFailState(msgFail: "${resultBean.msg}"));
      }
    });
    // 修改
    on<LabelTypeUpdateEvent>((event, emit) async {
      ResultBean resultBean = await typeRepository.updateType(event.data);
      if (resultBean.code == 0) {
        emit(LabelTypeSuccessState(msgSuccess: '修改成功'));
      } else {
        emit(LabelTypeFailState(msgFail: "${resultBean.msg}"));
      }
    });
    // 添加
    on<LabelTypeAddEvent>((event, emit) async {
      ResultBean resultBean = await typeRepository.addType(event.data);
      if (resultBean.code == 0) {
        emit(LabelTypeSuccessState(msgSuccess: '添加成功'));
      } else {
        emit(LabelTypeFailState(msgFail: "${resultBean.msg}"));
      }
    });
    // 展开折叠
    on<LabelTypeParentFoldEvent>((event, emit) async {
        emit(LabelTypeParentFoldState(index: event.index));
    });
  }
}
