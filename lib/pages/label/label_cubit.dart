import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/bean/result_bean.dart';
import 'package:website_nav/pages/label/label_state.dart';
import 'package:website_nav/repository/type_repository.dart';
import 'package:website_nav/utils/date_tool.dart';
import 'package:website_nav/utils/print_utils.dart';

class LabelCubit extends Cubit<LabelState> {
  ITypeRepository typeRepository = TypeRepository();

  LabelCubit() : super(LabelInitial());

  init() {
    emit(LabelInitial());
  }

  searchAllType(dynamic data) async {
    emit(LabelTypeLoadingState());
    ResultBean resultBean = await typeRepository.searchType(data);
    if (resultBean.code == 0) {
      emit(LabelTypeSearchSuccessState(type: "", typeData: resultBean.data));
    } else {
      emit(LabelTypeFailState(msgFail: "${resultBean.msg}"));
    }
  }

  reqInit() {
    printBlue("事件初始化");
    emit(LabelTypeInitialState(randomValue: DateTool.timestamp()));
  }

  reqSearchLabel(dynamic data) async {
    emit(LabelTypeLoadingState());
    ResultBean resultBean = await typeRepository.searchType(data);
    if (resultBean.code == 0) {
      emit(LabelTypeSearchSuccessState(type: "", typeData: resultBean.data));
    } else {
      emit(LabelTypeFailState(msgFail: "${resultBean.msg}"));
    }
  }

  reqSearchLabelParent(dynamic data) async {
    emit(LabelTypeLoadingState());
    ResultBean resultBean = await typeRepository.searchType(data);
    if (resultBean.code == 0) {
      emit(LabelTypeSearchSuccessState(type: "parent", typeData: resultBean.data));
    } else {
      emit(LabelTypeFailState(msgFail: "${resultBean.msg}"));
    }
  }

  // 删除
  reqDelLabelType(dynamic data) async {
    ResultBean resultBean = await typeRepository.delType(data);
    if (resultBean.code == 0) {
      emit(LabelTypeSuccessState(msgSuccess: '删除成功'));
    } else {
      emit(LabelTypeFailState(msgFail: "${resultBean.msg}"));
    }
  }

  // // 修改
  reqUpdateLabelType(dynamic data) async {
    ResultBean resultBean = await typeRepository.updateType(data);
    if (resultBean.code == 0) {
      emit(LabelTypeSuccessState(msgSuccess: '修改成功'));
    } else {
      emit(LabelTypeFailState(msgFail: "${resultBean.msg}"));
    }
  }
  


}
