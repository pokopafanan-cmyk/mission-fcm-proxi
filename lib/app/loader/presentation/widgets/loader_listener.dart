import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/widgets/common/app_loader.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../main.dart';
import '../bloc/loader_bloc.dart';

class LoaderListener extends StatefulWidget {

  final Widget child;

  const LoaderListener({super.key, required this.child});

  @override
  State<LoaderListener> createState() => _LoaderListenerState();
}

class _LoaderListenerState extends State<LoaderListener> {

  bool _dialogShown = false;

  NavigatorState? get _navigator => rootNavigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoaderBloc, LoaderState>(
      listenWhen: (prev, next) => prev.isLoading != next.isLoading,
      listener: (context, state) {

        final navigator = _navigator;
        if (navigator == null) {
          AppLogger.error("---------------------------------Navigator is null $_navigator +++++++++++++++++++++++++++++++++++++++");
          return;
        }

        if (state.isLoading && !_dialogShown) {
          _dialogShown = true;
          AppLoader.show(context: _navigator!.context);
        }

        if (!state.isLoading && _dialogShown) {
          _dialogShown = false;
          if (navigator.canPop()) {
            navigator.pop();
          }
        }
      },
      child: widget.child,
    );
  }
}
