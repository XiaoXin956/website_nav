import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'label_bloc.dart';
import 'label_event.dart';
import 'label_state.dart';

class LabelPage extends StatelessWidget {

  LabelBloc? labelBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LabelBloc,LabelState>(builder: (context,state){
      labelBloc = BlocProvider.of<LabelBloc>(context);


      return _buildPage(context);
    });
  }

  Widget _buildPage(BuildContext context) {

    return Container();
  }
}

