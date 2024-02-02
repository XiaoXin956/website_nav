import 'package:equatable/equatable.dart';
import 'package:website_nav/bean/type_bean.dart';

abstract class KnowledgeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// 初始化
class KnowledgeInitEvent extends KnowledgeEvent {}

// 添加资源
class KnowledgeAddDataEvent extends KnowledgeEvent{
  final dynamic map;
  KnowledgeAddDataEvent({this.map});
  @override
  List<Object?> get props => [map];
}

// 添加类型
class LabelTypeAddEvent extends KnowledgeEvent {
  final dynamic data;
  LabelTypeAddEvent({required this.data});
  @override
  List<Object?> get props => [data];
}


// 选择类型
class LabelTypeSelectChildEvent extends KnowledgeEvent {
  TypeBean? typeBean;
  LabelTypeSelectChildEvent({this.typeBean});
  @override
  List<Object?> get props => [typeBean];
}

// 查询类型
class LabelSearchEvent extends KnowledgeEvent {
  final dynamic data;
  LabelSearchEvent({required this.data});
  @override
  List<Object?> get props => [data];
}

// 查询资源
class KnowledgeSearchDataEvent extends KnowledgeEvent{
  final dynamic map;
  KnowledgeSearchDataEvent({required this.map});
  @override
  List<Object?> get props => [map];
}


// 编辑类型
class KnowledgeEditTypeEvent extends KnowledgeEvent{

}

class KnowledgeDelTypeEvent extends KnowledgeEvent{
  final dynamic data;

  KnowledgeDelTypeEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

