import 'package:bloc/bloc.dart';

import 'label_event.dart';
import 'label_state.dart';

class LabelBloc extends Bloc<LabelEvent, LabelState> {
  LabelBloc() : super(LabelTypeInitState()) {
    on<LabelInitEvent>((event, emit){

    });
  }


}
