part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class FetchAuthEvent extends AuthEvent {
  const FetchAuthEvent();

  @override
  List<Object> get props => <Object>[];
}

class SyncUserStateAuthEvent extends AuthEvent {
  const SyncUserStateAuthEvent({required this.auth});

  final AuthModel auth;

  @override
  List<Object> get props => <Object>[auth];
}

class CompleteAuthorization extends AuthEvent {
  const CompleteAuthorization({
    required this.token,
  });

  final String token;

  @override
  List<Object> get props => <Object>[token];
}

class SignOutAuthEvent extends AuthEvent {
  @override
  List<Object> get props => const <Object>[];
}
