import 'package:flutter/cupertino.dart';
import 'package:flutter_authentication/presentation/common/app_scaffold.dart';

class AuthenticatedRoute extends StatelessWidget {
  const AuthenticatedRoute({ super.key });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Text('YOU DO NOT NEED TO AUTHENTICATE'));
  }
}