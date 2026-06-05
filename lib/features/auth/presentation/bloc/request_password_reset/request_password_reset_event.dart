part of 'request_password_reset_bloc.dart';

sealed class RequestPasswordResetEvent extends Equatable {
  const RequestPasswordResetEvent();
}

/// Événement déclenché lors de la modification de l’email
final class RequestPasswordResetEmailChanged extends RequestPasswordResetEvent {

  final String email;

  const RequestPasswordResetEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

/// Événement déclenché lors de la soumission du formulaire
final class RequestPasswordResetSubmitted extends RequestPasswordResetEvent {

  @override
  List<Object> get props => [];
}
