import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'API_MAIN')
  static const mainApiUrl = _Env.mainApiUrl;

  @EnviedField(varName: 'API_CLIENTE')
  static const clientApiUrl = _Env.clientApiUrl;
}
