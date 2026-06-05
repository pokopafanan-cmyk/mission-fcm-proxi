part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;
  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends TimerState {
  const TimerInitial(super.duration);

  @override
  String toString() => "TimerInitial { duration: $duration }";
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(super.duration);

  @override
  String toString() => "TimerRunInProgress { duration: $duration }";
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}

class TimerLoading extends TimerState {
  const TimerLoading() : super(0);

  @override
  List<Object> get props => [];
}

class TimerLoaded extends TimerState {
  const TimerLoaded(): super(0);

  @override
  List<Object> get props => [];
}
