import 'package:equatable/equatable.dart';
import 'package:website_nav/bean/type_bean.dart';

abstract class LabelState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LabelTypeInitialState extends LabelState {
  dynamic randomValue;

  LabelTypeInitialState({this.randomValue});

  @override
  List<Object?> get props => [randomValue];
}

// 加载中
class LabelTypeLoadingState extends LabelState {
  LabelTypeLoadingState();
}

// 成功状态
class LabelTypeSuccessState extends LabelState {
  final String msgSuccess;

  LabelTypeSuccessState({required this.msgSuccess});

  @override
  List<Object?> get props => [msgSuccess];
}

// 失败状态
class LabelTypeFailState extends LabelState {
  final String msgFail;

  LabelTypeFailState({required this.msgFail});

  @override
  List<Object?> get props => [msgFail];
}

// 编辑
class LabelTypeEditState extends LabelState {
  bool? edit = false;

  LabelTypeEditState({this.edit});

  @override
  List<Object?> get props => [edit];
}

// 查询
class LabelTypeSearchSuccessState extends LabelState {
  final String type;
  final List<TypeLabelBean> typeData;

  LabelTypeSearchSuccessState({required this.typeData, required this.type});

  @override
  List<Object?> get props => [typeData];
}


class LabelInitial extends LabelState {}

class LabelZoomState extends LabelState {

  dynamic randomValue;

  LabelZoomState({this.randomValue});

  @override
  List<Object?> get props => [randomValue];
}

class LabelExpandState extends LabelState {

  final int index;

  LabelExpandState({required this.index});

  @override
  List<Object?> get props => [index];

}