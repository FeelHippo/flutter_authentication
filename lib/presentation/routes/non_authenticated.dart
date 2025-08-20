import 'package:flutter/cupertino.dart';
import 'package:flutter_authentication/presentation/common/app_scaffold.dart';

class NonAuthenticatedRoute extends StatelessWidget {
  const NonAuthenticatedRoute({ super.key });
  
  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Text('YOU NEED TO AUTHENTICATE'));
  }
}