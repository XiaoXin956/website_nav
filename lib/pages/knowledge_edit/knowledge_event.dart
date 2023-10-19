import 'package:equatable/equatable.dart';
import 'package:website_nav/bean/type_bean.dart';

abstract class KnowledgeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class KnowledgeInitEvent extends KnowledgeEvent {}

class KnowledgeAddDataEvent extends KnowledgeEvent{

  final dynamic map;

  KnowledgeAddDataEvent({this.map});

  @override
  List<Object?> get props => [map];

}

class KnowledgeEditDataEvent extends KnowledgeEvent{

  final dynamic map;

  KnowledgeEditDataEvent({this.map});

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
class LabelTypeSelectEvent extends KnowledgeEvent {

  TypeBean? typeBean;

  LabelTypeSelectEvent({this.typeBean});

  @override
  List<Object?> get props => [typeBean];
}


class LabelSearchEvent extends KnowledgeEvent {

  final dynamic data;

  LabelSearchEvent({required this.data});

  @override
  List<Object?> get props => [data];

}


