import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  AuthModel({ required this.token });

  AuthModel.empty() : token = '';
  bool get isEmpty => token.isEmpty;

  final String token;

  @override
  List<Object?> get props => <Object?>[token];
}
