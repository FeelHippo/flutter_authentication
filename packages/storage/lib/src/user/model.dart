import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel(
    this.uid,
    this.name,
  );

  bool get isEmpty => uid.isEmpty || name.isEmpty;

  final String uid;
  final String name;
  // ... more user data here

  @override
  List<Object> get props => <Object>[uid, name];
}
