import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:website_nav/bean/knowledge_bean.dart';
import 'package:website_nav/bean/result_bean.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/repository/knowledge_repository.dart';
import 'package:website_nav/repository/type_repository.dart';

import 'knowledge_event.dart';
import 'knowledge_state.dart';

class KnowledgeBloc extends Bloc<KnowledgeEvent, KnowledgeState> {

  TypeRepository typeRepository = TypeRepository();
  IKnowledgeRepository knowledgeRepository = KnowledgeRepository();

  KnowledgeBloc() : super(KnowledgeState()) {
    on<KnowledgeInitEvent>((event, emit) {
      emit(KnowledgeInitState());
    });
    // 添加
    on<LabelTypeAddEvent>((event, emit) async {
      ResultBean resultBean = await typeRepository.addType(event.data);
      if (resultBean.code == 0) {
        emit(LabelTypeAddSuccessState(type: event.data['type'], msgSuccess: resultBean.msg.toString(), typeBean: null));
      } else {
        emit(LabelTypeFailState(msgFail: "${resultBean.msg}"));
      }
    });
    // 选择一级类型
    on<LabelTypeSelectParentEvent>((event, emit) async {
      emit(LabelTypeSelectParentState(typeBean: event.typeBean));
    });
    // 选择类型
    on<LabelTypeSelectChildEvent>((event, emit) async {
      emit(LabelTypeSelectChildState(typeBean: event.typeBean));
    });
    // 查询类型
    on<LabelSearchEvent>((event, emit) async {
      ResultBean resultBean = await typeRepository.searchType(event.data);
      if (resultBean.code == 0) {
        emit(LabelTypeSearchSuccessState(type: "${event.data['type']}", typeData: resultBean.data));
      } else {
        emit(LabelTypeFailState(msgFail: "${resultBean.msg}"));
      }
    });
    // 添加内容
    on<KnowledgeAddDataEvent>((event, emit) async {
      emit(KnowledgeLoadingState());
      ResultBean resultBean = await knowledgeRepository.addKnowledge(event.map);
      if (resultBean.code == 0) {
        emit(KnowledgeAddSuccessState(msgSuccess: resultBean.msg.toString()));
      } else {
        emit(KnowledgeFailState(msgFail: "${resultBean.msg}"));
      }
    });

    // 查询所有内容
    on<KnowledgeSearchDataEvent>((event, emit) async {
      // 数据获取中
      emit(KnowledgeLoadingState());
      ResultBean resultBean = await knowledgeRepository.searchKnowledge(event.map);
      if (resultBean.code == 0) {
        var decode = json.decode(resultBean.data);
        dynamic result = (decode as List<dynamic>).map((e) {
          return {"type_bean": TypeBean.fromJson(e['type_bean']),
            "know_data": (e['result'] as List<dynamic>)
                .map((e) => KnowledgeBean.fromJson(e))
                .toList(),};
        }).toList();
        emit(KnowledgeSearchDataState(knowData:result));
      } else {
        emit(KnowledgeFailState(msgFail: "${resultBean.msg}"));
      }
      // 获取成功

      // 成功

      // 失败

    });


  }


}
