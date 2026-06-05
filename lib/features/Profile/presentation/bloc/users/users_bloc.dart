import '../../../../../core/common/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/config/enums.dart';
import '../../../domain/usecases/get_users.dart';

part 'users_event.dart';
part 'users_state.dart';


class UsersBloc extends Bloc<UsersEvent, UsersState> {

  /// UseCase chargé de récupérer la liste des utilisateurs
  final GetUsers getUsers;

  UsersBloc({required this.getUsers}) : super(const UsersState()) {
    on<UsersRequested>(_onUsersRequested);
    on<UsersRefreshed>(_onUsersRefreshed);
    on<UsersFiltered>(_onUsersFiltered);
  }

  /// Chargement initial des utilisateurs
  Future<void> _onUsersRequested(UsersRequested event, Emitter<UsersState> emit,) async {

    // Déclenche l'état de chargement
    emit(state.copyWith(status: Status.loading));

    final res = await getUsers(GetUsersParams());

    res.fold(
      (failure) => emit(
        state.copyWith(
          status: Status.failure,
          message: failure.message,
        ),
      ),
      (users) => emit(
        state.copyWith(
          status: Status.success,
          allUsers: users,
          users: users,
          hasReachedMax: true,
        ),
      ),
    );
  }

  /// Rafraîchissement de la liste
  Future<void> _onUsersRefreshed(UsersRefreshed event, Emitter<UsersState> emit,) async {

    // Déclenche l'état de chargement
    emit(state.copyWith(status: Status.loading));

    // Appel du UseCase de récupération des utilisateurs
    final res = await getUsers(GetUsersParams());

    res.fold(
      (failure) => emit(
        state.copyWith(
          status: Status.failure,
          message: failure.message,
        ),
      ),
      (users) => emit(
        state.copyWith(
          status: Status.success,
          allUsers: users,
          users: users,
          hasReachedMax: true,
        ),
      ),
    );
  }

  /// Filtrage local des utilisateurs
  void _onUsersFiltered(UsersFiltered event, Emitter<UsersState> emit,) {

    final query = event.query.toLowerCase().trim();

    if (query.isEmpty) {
      // Si la recherche est vide, on réaffiche tout
      emit(state.copyWith(users: state.allUsers));
      return;
    }

    final filtered = state.allUsers.where((user) {
      return user.nom.toLowerCase().contains(query) ||
          user.prenoms.toLowerCase().contains(query) ||
          user.displayMobile.toLowerCase().contains(query) ||
          user.email.toLowerCase().contains(query);
    }).toList();

    emit(state.copyWith(users: filtered));
  }
}


