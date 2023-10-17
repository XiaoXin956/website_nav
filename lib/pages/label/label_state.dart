import 'package:equatable/equatable.dart';
import 'package:website_nav/bean/type_bean.dart';

abstract class LabelState extends Equatable{
  @override
  List<Object?> get props => [];
}

class LabelTypeInitialState extends LabelState{

  LabelTypeInitialState();

}

class LabelTypeLoadingState extends LabelState {

  LabelTypeLoadingState();

}

// 成功状态
class LabelTypeSuccessState extends LabelState{
  final String msgSuccess;

  LabelTypeSuccessState({required this.msgSuccess});

  @override
  List<Object?> get props => [msgSuccess];
}

// 失败状态
class LabelTypeFailState extends LabelState{
  final String msgFail;

  LabelTypeFailState({required this.msgFail});

  @override
  List<Object?> get props => [msgFail];
}


// 类型添加成功
class LabelTypeAddSuccessState extends LabelState{

}

// 编辑
class LabelTypeEditState extends LabelState{

  bool? edit = false;

  LabelTypeEditState({this.edit});

  @override
  List<Object?> get props => [edit];
}

class LabelTypeSearchSuccessState extends LabelState {
  final List<TypeBean> typeData;

  LabelTypeSearchSuccessState({required this.typeData});

  @override
  List<Object?> get props => [typeData];
}
