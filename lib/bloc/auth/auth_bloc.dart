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
    this._loginRepository,
    this._userPreferences,
  ) : super(
          const AuthState(
            loading: Loading.initializing,
            auth: InitialAuthUiModel(),
          ),
        ) {
    on<FetchAuthEvent>(_handleFetchAuth);
    on<SyncUserStateAuthEvent>(_handleSyncUserStateAuth);
    on<CompleteOnboarding>(_handleCompleteOnboarding);
    on<SignOutAuthEvent>(_handleSignOutAuth);
    on<FetchLoginData>(_handleFetchLoginData);
  }

  final AuthRepository _authRepository;
  final LoginRepository _loginRepository;
  final UserPreferences _userPreferences;

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
      final bool isAccountDeleted = await _userPreferences.getBool(
        key: StoreUserPreferences.prefIsAccountDeleted,
      );
      if (isAccountDeleted) {
        await _userPreferences.putBool(
          key: StoreUserPreferences.prefIsAccountDeleted,
          value: false,
        );
        emit(
          state.copyWith(
            loading: Loading.none,
            auth: const DeleteAccountUiModel(),
          ),
        );
      } else {
        await emitStateUnauthorized(emit);
      }
    } else {
      try {
        emit(state.copyWith(loading: Loading.loading));
        emit(
          await _processAuthorisation(
            token: event.auth.token,
          ),
        );
      } catch (e, stacktrace) {
        print(
          'Error occurred while trying to authorize $e $stacktrace'
        );
        emit(state.copyWith(loading: Loading.none, error: e));
      }
    }
  }

  FutureOr<void> _handleCompleteOnboarding(
    CompleteOnboarding event,
    Emitter<AuthState> emit,
  ) async {
    final UserModel? user = await _authRepository.authorize(event.token);
    if (user != null) {
      emit(
        state.copyWith(
          loading: Loading.none,
          auth: AuthorizedAuthUiModel(
            user,
          ),
        ),
      );
    }
  }

  FutureOr<void> _handleSignOutAuth(
    SignOutAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    await emitStateUnauthorized(emit);
  }

  FutureOr<void> _handleFetchLoginData(
    FetchLoginData event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(loading: Loading.loading));
    try {
      await _loginRepository.completeLogin(
        token: event.token,
        userUid: event.userUid,
      );
    } catch (e) {
      emit(state.copyWith(loading: Loading.none, error: e));
    }
  }

  Future<AuthState> _processAuthorisation({
    required String token,
  }) async {
    final UserModel? user = await _authRepository.authorize(token);
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
