# flutter_authentication

Flutter response to
my [Jetpack Compose](https://github.com/FeelHippo/android_jetpack_authentication) authentication
scaffold.

- [Architecture](https://engineering.verygood.ventures/architecture/)
- [Inversion of Control](https://stackoverflow.com/a/3140/10708345)
  via [Flutter Injector](https://pub.dev/packages/injector)
- [DI](https://developer.android.com/training/dependency-injection/manual), where `injector.dart`
  serves as a dependencies container
- [Repository Pattern](https://codewithandrea.com/articles/flutter-repository-pattern/)

### Run

- clone the backend end [service](https://github.com/FeelHippo/django_authentication)
- run it (see instructions in Readme)
- head to `packages/api_client/lib/src/dio/dio_factory.dart` and replace the base url with your
  ngrok tunnel
