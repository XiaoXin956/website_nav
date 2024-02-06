part of 'feedback_cubit.dart';

abstract class FeedbackState extends Equatable {
  const FeedbackState();
  @override
  List<Object> get props => [];
}

class FeedbackInitial extends FeedbackState {
}

class FeedbackLoadingState extends FeedbackState {
}

class FeedbackDataState extends FeedbackState {
}

class FeedbackSubmitSuccessState extends FeedbackState {
}

class FeedbackFailedState extends FeedbackState {
}