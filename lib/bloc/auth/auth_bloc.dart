import 'dart:async';

import 'package:apiClient/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage/main.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._authRepository,
    this._authenticationRepository,
  ) : super(
        const AuthState(
          loading: Loading.initializing,
          auth: InitialAuthUiModel(),
        ),
      ) {
    on<FetchAuthEvent>(_handleFetchAuth);
    on<SyncUserStateAuthEvent>(_handleSyncUserStateAuth);
    on<CompleteAuthorization>(_handleCompleteAuthorization);
    on<SignOutAuthEvent>(_handleSignOutAuth);
  }

  // device storage
  final AuthRepository _authRepository;

  // network
  final AuthenticationRepository _authenticationRepository;

  StreamSubscription<AuthModel>? _subscription;

  FutureOr<void> _handleFetchAuth(
    FetchAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    _subscription ??= _authRepository.get().listen((AuthModel auth) {
      add(
        SyncUserStateAuthEvent(auth: auth),
      );
    });
  }

  FutureOr<void> _handleSyncUserStateAuth(
    SyncUserStateAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (event.auth.isEmpty) {
      await emitStateUnauthorized(emit);
    } else {
      try {
        emit(state.copyWith(loading: Loading.loading));
        final BaseAuthModel userData = await _authenticationRepository
            .getUserById(
              id: event.auth.userUid!,
            );
        emit(
          await _processAuthorisation(
            authenticationModel: AuthenticationModel(
              token: event.auth.token!,
              id: userData.id,
              email: userData.email,
              username: userData.username,
              firstName: userData.firstName,
              lastName: userData.lastName,
            ),
          ),
        );
      } catch (e, stacktrace) {
        print('Error occurred while trying to authorize $e $stacktrace');
        emit(state.copyWith(loading: Loading.none, error: e));
      }
    }
  }

  FutureOr<void> _handleCompleteAuthorization(
    CompleteAuthorization event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      await _processAuthorisation(
        authenticationModel: event.authenticationModel,
      ),
    );
  }

  FutureOr<void> _handleSignOutAuth(
    SignOutAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    await emitStateUnauthorized(emit);
  }

  Future<AuthState> _processAuthorisation({
    required AuthenticationModel authenticationModel,
  }) async {
    final UserModel? user = await _authRepository.authorize(
      authenticationModel: authenticationModel,
    );
    if (user != null) {
      /// User exists and is authenticated
      return state.copyWith(
        loading: Loading.none,
        auth: AuthorizedAuthUiModel(
          user,
        ),
      );
    } else {
      return state.copyWith(
        loading: Loading.none,
        auth: UnauthorizedAuthUiModel(),
      );
    }
  }

  Future<void> emitStateUnauthorized(Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        loading: Loading.none,
        auth: UnauthorizedAuthUiModel(),
      ),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
