import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'loader_event.dart';
part 'loader_state.dart';

class LoaderBloc extends Bloc<LoaderEvent, LoaderState> {

  LoaderBloc() : super(const LoaderState()) {

    on<LoaderShown>((event, emit) {
      // On incrémente le nombre de processus actifs
      emit(LoaderState(
        status: LoaderStatus.visible,
        activeRequests: state.activeRequests + 1,
        message: event.message,
      ));
    });

    on<LoaderHidden>((e, emit) {
      final newCount = state.activeRequests - 1;
      if (newCount <= 0) {
        // On ne cache vraiment que si plus personne ne demande de loader
        emit(const LoaderState());
      } else {
        emit(state.copyWith(activeRequests: newCount));
      }
    });
  }
}
