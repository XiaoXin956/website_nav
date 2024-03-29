import 'package:equatable/equatable.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/utils/date_tool.dart';

class KnowledgeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class KnowledgeInitState extends KnowledgeState {}

class KnowledgeLoadingState extends KnowledgeState {}

// 添加成功
class KnowledgeAddSuccessState extends KnowledgeState {
  final String msgSuccess;

  KnowledgeAddSuccessState({required this.msgSuccess});

  @override
  List<Object?> get props => [msgSuccess];
}

class KnowledgeSuccessState extends KnowledgeState {
  final String msgSuccess;

  KnowledgeSuccessState({required this.msgSuccess});

  @override
  List<Object?> get props => [msgSuccess];
}

class KnowledgeFailState extends KnowledgeState {
  final String msgFail;

  KnowledgeFailState({required this.msgFail});

  @override
  List<Object?> get props => [msgFail];
}

class LabelTypeFailState extends KnowledgeState {

  final String timestamp;
  final String msgFail;

  LabelTypeFailState({required this.msgFail, required this.timestamp});

  @override
  List<Object?> get props => [msgFail, timestamp];
}

// 类型添加成功
class LabelTypeAddSuccessState extends KnowledgeState {
  final String type;
  final String msgSuccess;
  final TypeBean? typeBean;

  LabelTypeAddSuccessState({required this.typeBean, required this.type, required this.msgSuccess});

  @override
  List<Object?> get props => [typeBean, type, msgSuccess];
}

// 查询
class LabelTypeSearchSuccessState extends KnowledgeState {
  final String type;
  final List<TypeBean> typeData;

  LabelTypeSearchSuccessState({required this.typeData, required this.type});

  @override
  List<Object?> get props => [typeData];
}

class LabelTypeSelectChildState extends KnowledgeState {
  final TypeBean? typeBean;

  LabelTypeSelectChildState({required this.typeBean});

  @override
  List<Object?> get props => [typeBean];
}

class KnowledgeSearchDataState extends KnowledgeState {
  final dynamic knowData;

  KnowledgeSearchDataState({required this.knowData});

  @override
  List<Object?> get props => [knowData];
}

class KnowledgeEditTypeState extends KnowledgeState {
  final bool isEdit;

  KnowledgeEditTypeState({required this.isEdit});

  @override
  List<Object?> get props => [isEdit];
}


class KnowledgeUploadLoadingState extends KnowledgeState {}

class KnowledgeUploadIconSuccessState extends KnowledgeState {
    final String imageUrl;

    KnowledgeUploadIconSuccessState({required this.imageUrl});
    @override
  List<Object?> get props => [imageUrl];
}

class KnowledgeUploadIconFailState extends KnowledgeState {
    final String msg;

    KnowledgeUploadIconFailState({required this.msg});
    @override
  List<Object?> get props => [msg];
}



