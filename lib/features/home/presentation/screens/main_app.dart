import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {

  final Widget child;

  const MainApp({super.key, required this.child});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    // context.read<AppLockBloc>().add(AppLockRequested(reason: LockReason.startup));
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // final bloc = context.read<AppLockBloc>();

    switch (state) {
      case AppLifecycleState.paused:
        // bloc.add(const AppBackgrounded());
        break;

      case AppLifecycleState.resumed:
        // bloc.add(const AppForegrounded());
        break;

      default:
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return widget.child;

    // return LockListener(
    //   child: widget.child,
    // );
  }
}
