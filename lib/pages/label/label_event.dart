abstract class LabelEvent {}

class LabelTypeInitialEvent extends LabelEvent {
  @override
  List<Object?> get props => [];
}

class LabelTypeAddEvent extends LabelEvent {
  final dynamic data;

  LabelTypeAddEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class LabelTypeDelEvent extends LabelEvent {
  final dynamic data;

  LabelTypeDelEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class LabelTypeUpdateEvent extends LabelEvent {
  final dynamic data;

  LabelTypeUpdateEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class LabelChildSearchEvent extends LabelEvent{

  final dynamic data;

  LabelChildSearchEvent({required this.data});

  @override
  List<Object?> get props => [data];

}

class LabelParentSearchEvent extends LabelEvent{

  final dynamic data;

  LabelParentSearchEvent({required this.data});

  @override
  List<Object?> get props => [data];

}

// 查询所有
class LabelTypeAllSearchEvent extends LabelEvent{

  final dynamic data;

  LabelTypeAllSearchEvent({required this.data});

  @override
  List<Object?> get props => [data];

}

// 查询所有
class LabelTypeEditEvent extends LabelEvent{

  bool? edit = false;

  LabelTypeEditEvent({this.edit});

  @override
  List<Object?> get props => [edit];
}


// 折叠操作
class LabelTypeParentFoldEvent extends LabelEvent{

  final dynamic index;

  LabelTypeParentFoldEvent({this.index});

  @override
  List<Object?> get props => [index];
}


