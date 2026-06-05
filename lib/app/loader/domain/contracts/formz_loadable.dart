import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'loadable_state.dart';

abstract class FormzLoadable extends Equatable implements LoadableState {

  FormzSubmissionStatus get submissionStatus;

  @override
  bool get isLoading => submissionStatus.isInProgress;

  @override
  bool get isFinished => submissionStatus.isSuccess || submissionStatus.isFailure;
}

