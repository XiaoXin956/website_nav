import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/pages/feedback/feedback_cubit.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedbackCubit>(
      create: (context) => FeedbackCubit(),
      child: BlocBuilder<FeedbackCubit, FeedbackState>(
        builder: (context, state) {


          if(state is FeedbackInitial){

          }else if(state is FeedbackLoadingState){

          }else if(state is FeedbackDataState){

          }else if(state is FeedbackSubmitSuccessState){

          }else if(state is FeedbackFailedState){

          }


          return Scaffold(
            body: Center(
              child: Text('Feedback'),
            ),
          );
        },
      ),
    );
  }



}
