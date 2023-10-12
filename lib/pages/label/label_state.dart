import 'package:equatable/equatable.dart';

abstract class LabelState extends Equatable{
  @override
  List<Object?> get props => [];
}

class LabelTypeInitState extends LabelState{

  LabelTypeInitState();

}

class LabelTypeSuccessState extends LabelState{
  final String msgSuccess;

  LabelTypeSuccessState({required this.msgSuccess});

  @override
  List<Object?> get props => [msgSuccess];
}

class LabelTypeFailState extends LabelState{
  final String msgFail;

  LabelTypeFailState({required this.msgFail});

  @override
  List<Object?> get props => [msgFail];
}


class LabelTypeChildAddSuccessState extends LabelState{

}

