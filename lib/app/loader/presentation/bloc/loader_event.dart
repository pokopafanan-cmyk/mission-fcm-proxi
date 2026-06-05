part of 'loader_bloc.dart';

sealed class LoaderEvent {}

final class LoaderShown extends LoaderEvent {
  final String message;
  LoaderShown({this.message = "Patientez s'il vous plait..."});
}

final class LoaderHidden extends LoaderEvent {}
