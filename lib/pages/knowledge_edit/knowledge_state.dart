import 'package:equatable/equatable.dart';
import 'package:website_nav/bean/type_bean.dart';

class KnowledgeState extends Equatable{
  @override
  List<Object?> get props => [];
}

class KnowledgeInitState extends KnowledgeState{

}

class KnowledgeAddSuccessState extends KnowledgeState{

}// 标签

class KnowledgeEditSuccessState extends KnowledgeState{

}

class KnowledgeSuccessState extends KnowledgeState{

  final String msgSuccess;

  KnowledgeSuccessState({required this.msgSuccess});

  @override
  List<Object?> get props => [msgSuccess];

}
class KnowledgeFailState extends KnowledgeState{

  final String msgFail;

  KnowledgeFailState({required this.msgFail});

  @override
  List<Object?> get props => [msgFail];
}
class LabelTypeFailState extends KnowledgeState{

  final String msgFail;

  LabelTypeFailState({required this.msgFail});

  @override
  List<Object?> get props => [msgFail];
}

// 类型添加成功
class LabelTypeAddSuccessState extends KnowledgeState {
  final String type;
  final String msgSuccess;
  final TypeBean? typeBean;

  LabelTypeAddSuccessState({required this.typeBean, required this.type, required this.msgSuccess});

  @override
  List<Object?> get props => [typeBean,type,msgSuccess];
}

// 查询
class LabelTypeSearchSuccessState extends KnowledgeState {
  final String type;
  final List<TypeBean> typeData;

  LabelTypeSearchSuccessState({required this.typeData, required this.type});

  @override
  List<Object?> get props => [typeData];
}


class LabelTypeSelectParentState extends KnowledgeState {
  final TypeBean? typeBean;

  LabelTypeSelectParentState({required this.typeBean});

  @override
  List<Object?> get props => [typeBean];
}

class LabelTypeSelectChildState extends KnowledgeState {
  final TypeBean? typeBean;

  LabelTypeSelectChildState({required this.typeBean});

  @override
  List<Object?> get props => [typeBean];
}