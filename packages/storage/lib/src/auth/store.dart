import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:storage/main.dart';

class StoreAuthProvider extends AuthProvider {
  StoreAuthProvider(FlutterSecureStorage _storage) : _storage = _storage {
    // A special StreamController that captures the latest item that has been added to the controller,
    // and emits that as the first item to any new listener.
    _subject = BehaviorSubject<AuthModel>(
      onListen: () async {
        final String? token = await _storage.read(key: _tokenKey);
        doTokenWork(token: token);
      },
    );
  }

  static const String _tokenKey = 'token';
  final FlutterSecureStorage _storage;
  Subject<AuthModel>? _subject;

  void doTokenWork({required String? token}) {
    AuthModel model;
    if (token == null || token.isEmpty) {
      model = AuthModel.empty();
    } else {
      model = AuthModel(token: token);
    }
    _subject!.add(model);
  }

  @override
  Stream<AuthModel> get() {
    // "distinct" skips data events if they are equal to the previous data event.
    return _subject!.distinct();
  }

  @override
  Future<void> put(AuthModel model) async {
    if (model.isEmpty) {
      await _storage.delete(key: _tokenKey);
      _subject!.add(AuthModel.empty());
    } else {
      await _storage.write(key: _tokenKey, value: model.token);
      _subject!.add(AuthModel(token: model.token));
    }
    return;
  }

  @override
  Future<void> remove() async {
    await put(AuthModel.empty());
  }
}
