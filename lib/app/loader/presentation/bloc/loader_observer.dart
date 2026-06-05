import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/show_message.dart';
import '../../domain/contracts/loadable_state.dart';
import '../../domain/entities/user_message.dart';
import 'loader_bloc.dart';

class LoaderObserver extends BlocObserver {

  final LoaderBloc loaderBloc;

  LoaderObserver(this.loaderBloc);

  final Set<String> _shownMessagesIds = {};

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    final prev = change.currentState;
    final next = change.nextState;

    // Filtrer : On ne traite que les LoadableState
    if (prev is! LoadableState || next is! LoadableState) return;

    // Vérifier le mode silencieux (remplace votre mixin statique)
    if (next.silentMode) return;

    // Logique de déclenchement
    if (!prev.isLoading && next.isLoading) {
      loaderBloc.add(LoaderShown());
    }
    else if (prev.isLoading && next.isFinished) {
      loaderBloc.add(LoaderHidden());
    }

    final message = next.message;

    if (message != null && !_shownMessagesIds.contains(message.id)) {
      _shownMessagesIds.add(message.id);

      AppMessage.showToast(
        msg: next.message!.text,
        isError: message.type == MessageType.error,
      );
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    // Si un bloc crash pendant qu'il charge, on décrémente
    if (bloc.state is LoadableState && (bloc.state as LoadableState).isLoading) {
      loaderBloc.add(LoaderHidden());
    }
  }
}