import 'package:bloc/bloc.dart';
import 'package:website_nav/bean/result_bean.dart';
import 'package:website_nav/repository/type_repository.dart';

import 'knowledge_event.dart';
import 'knowledge_state.dart';

class KnowledgeBloc extends Bloc<KnowledgeEvent, KnowledgeState> {

  TypeRepository typeRepository = TypeRepository();

  KnowledgeBloc() : super(KnowledgeState()) {
    on<KnowledgeInitEvent>((event, emit){});

    // 添加
    on<LabelTypeAddEvent>((event, emit) async {
      ResultBean resultBean = await typeRepository.addType(event.data);
      if (resultBean.code == 0) {
        emit(LabelTypeAddSuccessState(type: event.data['type'],msgSuccess: resultBean.msg.toString(),typeBean: null));
      } else {
        emit(LabelTypeFailState(msgFail: "${resultBean.msg}"));
      }
    });
    // 选择类型
    on<LabelTypeSelectEvent>((event, emit) async {
      emit(LabelTypeSelectState(typeBean: event.typeBean));
    });
    // 选择类型
    on<LabelSearchEvent>((event, emit) async {
      ResultBean resultBean = await typeRepository.searchType(event.data);
      if (resultBean.code == 0) {
        emit(LabelTypeSearchSuccessState(type: "${event.data['type']}",typeData: resultBean.data));
      } else {
        emit(LabelTypeFailState(msgFail: "${resultBean.msg}"));
      }
    });
  }


}
