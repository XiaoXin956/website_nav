import 'package:bloc/bloc.dart';
import 'package:website_nav/bean/result_bean.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/pages/label/label_state.dart';
import 'package:website_nav/repository/type_repository.dart';
import 'package:website_nav/utils/date_tool.dart';


class LabelCubit extends Cubit<LabelState> {
  ITypeRepository typeRepository = TypeRepository();
  LabelCubit() : super(LabelInitial());

  init(){
    emit(LabelInitial());
  }

  // 扩展与缩小
  zoom(){
    emit(LabelZoomState(randomValue: DateTool.timestamp()));
  }

  // 选择
  selectIndex({required int index,required TypeBean typeBean}){
    emit(LabelSelectIndexState(index: index,typeBean: typeBean));
  }

  searchAllType(dynamic data) async {
    emit(LabelTypeLoadingState());
    ResultBean resultBean = await typeRepository.searchType(data);
    if (resultBean.code == 0) {
      emit(LabelTypeSearchSuccessState(type: "",typeData: resultBean.data));
    } else {
      emit(LabelTypeFailState(msgFail: "${resultBean.msg}"));
    }
  }


}
