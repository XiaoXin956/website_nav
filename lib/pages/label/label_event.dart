abstract class LabelEvent {}

class LabelInitEvent extends LabelEvent {
  @override
  List<Object?> get props => [];
}

class LabelChildAddEvent extends LabelEvent {
  final dynamic data;

  LabelChildAddEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class LabelChildUpdateEvent extends LabelEvent {
  final dynamic data;

  LabelChildUpdateEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class LabelChildDelEvent extends LabelEvent {
  final dynamic data;

  LabelChildDelEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

////////////  父级
class LabelParentAddEvent extends LabelEvent {
  final dynamic data;

  LabelParentAddEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class LabelParentUpdateEvent extends LabelEvent {
  final dynamic data;

  LabelParentUpdateEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class LabelParentDelEvent extends LabelEvent {
  final dynamic data;

  LabelParentDelEvent({required this.data});

  @override
  List<Object?> get props => [data];
}
