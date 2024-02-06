import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/bean/knowledge_bean.dart';
import 'package:website_nav/bean/result_bean.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/pages/knowledge_edit/knowledge_state.dart';
import 'package:website_nav/repository/knowledge_repository.dart';
import 'package:website_nav/repository/type_repository.dart';
import 'package:website_nav/utils/date_tool.dart';

class KnowledgeCubit extends Cubit<KnowledgeState> {

  KnowledgeCubit() : super(KnowledgeState());

  ITypeRepository typeRepository = TypeRepository();
  IKnowledgeRepository knowledgeRepository = KnowledgeRepository();

  reqKnowledgeInit() {
    emit(KnowledgeInitState());
  }

  reqKnowledgeTypeAdd({dynamic data}) async {
    if (data.toString().length > 30) {
      emit(LabelTypeFailState(msgFail: "类型名称不能超过30个字符", timestamp: DateTool.timestamp()));
      return;
    }
    ResultBean resultBean = await typeRepository.addType(data);
    if (resultBean.code == 0) {
      emit(LabelTypeAddSuccessState(type: data['type'], msgSuccess: resultBean.msg.toString(), typeBean: null));
    } else {
      emit(LabelTypeFailState(msgFail: "${resultBean.msg}", timestamp: DateTool.timestamp()));
    }
  }

  // 选择类型
  selectKnowledgeType({required TypeBean typeBean}) {
    emit(LabelTypeSelectChildState(typeBean: typeBean));
  }

  // 查询类型
  reqSearchType({dynamic data}) async {
    ResultBean resultBean = await typeRepository.searchType(data);
    if (resultBean.code == 0) {
      emit(LabelTypeSearchSuccessState(type: "${data['type']}", typeData: resultBean.data));
    } else {
      emit(LabelTypeFailState(msgFail: "${resultBean.msg}", timestamp: DateTool.timestamp()));
    }
  }

  reqAddKnowledgeData({dynamic data}) async {
    emit(KnowledgeLoadingState());
    ResultBean resultBean = await knowledgeRepository.addKnowledge(data);
    if (resultBean.code == 0) {
      emit(KnowledgeAddSuccessState(msgSuccess: resultBean.msg.toString()));
    } else {
      emit(KnowledgeFailState(msgFail: "${resultBean.msg}"));
    }
  }

  reqDelKnowledgeData({dynamic data}) async {
    ResultBean resultDel = await knowledgeRepository.delKnowledge(data);
    if (resultDel.code == 0) {
      emit(KnowledgeSuccessState(msgSuccess: "${resultDel.msg}"));
    } else {
      emit(KnowledgeFailState(msgFail: "${resultDel.msg}"));
    }
  }

  // 查询所有内容
  reqSearchAllKnowledgeData({dynamic data}) async {
    emit(KnowledgeLoadingState());
    ResultBean resultBean = await knowledgeRepository.searchKnowledge(data);
    if (resultBean.code == 0) {
      var decode = json.decode(resultBean.data);
      dynamic result = (decode as List<dynamic>).map((e) {
        return {
          "type_bean": TypeBean.fromJson(e['type_bean']),
          "know_data": (e['result'] as List<dynamic>).map((e) => KnowledgeBean.fromJson(e)).toList(),
        };
      }).toList();
      emit(KnowledgeSearchDataState(knowData: result));
    } else {
      emit(KnowledgeFailState(msgFail: "${resultBean.msg}"));
    }
  }

  // 打开编辑类型
  editType({required bool isEdit}) {
    emit(KnowledgeEditTypeState(isEdit: isEdit));
  }

  // 删除类型
  delType({dynamic data}) async {
    ResultBean resultBean = await typeRepository.delType(data);
    if (resultBean.code == 0) {
      emit(KnowledgeSuccessState(msgSuccess: '${resultBean.msg}'));
    } else {
      emit(KnowledgeFailState(msgFail: "${resultBean.msg}"));
    }
  }



  // 上传图标
  uploadIcon({required dynamic data}) async {
    emit(KnowledgeUploadLoadingState());
    ResultBean resultBean = await knowledgeRepository.uploadIcon(data);
    if (resultBean.code == 0) {
      emit(KnowledgeUploadIconSuccessState(imageUrl: resultBean.data.toString()));
    } else {
      emit(KnowledgeFailState(msgFail: "${resultBean.msg}"));
    }
  }








}
