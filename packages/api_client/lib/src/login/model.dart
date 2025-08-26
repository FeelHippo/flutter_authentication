import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  const LoginModel({
    required this.token,
    required this.userUid,
  });

  bool get isValid => token.isNotEmpty && userUid.isNotEmpty;

  final String token;
  final String userUid;

  @override
  List<Object> get props => <Object>[token, userUid];
}
