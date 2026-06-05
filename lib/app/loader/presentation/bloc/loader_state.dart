part of 'loader_bloc.dart';

enum LoaderStatus { hidden, visible }

class LoaderState extends Equatable {

  final LoaderStatus status;
  final int activeRequests; // Compteur de processus
  final String message;

  const LoaderState({
    this.status = LoaderStatus.hidden,
    this.activeRequests = 0,
    this.message = "Patientez s'il vous plait...",
  });


  /// Helpers UI
  // bool get isLoading => activeRequests > 0;
  bool get isLoading => status == LoaderStatus.visible && activeRequests > 0;

  LoaderState copyWith({
    LoaderStatus? status,
    int? activeRequests,
    String? message
  }) {
    return LoaderState(
      status: status ?? this.status,
      activeRequests: activeRequests ?? this.activeRequests,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, activeRequests, message];
}
