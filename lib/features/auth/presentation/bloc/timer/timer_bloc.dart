import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {

  static const int _duration = 60;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc() : super(const TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
  }

  Stream<int> _tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1).take(ticks);
  }


  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _tick(ticks: event.duration).listen((duration) => add(TimerTicked(duration: duration)));
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(event.duration > 0 ? TimerRunInProgress(event.duration) : const TimerRunComplete(),); // 591229
  }


  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}

