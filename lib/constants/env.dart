import "package:envied/envied.dart";

part "env.g.dart";

@Envied(path: ".env", useConstantCase: true, obfuscate: true)
abstract class Env {
  @EnviedField()
  static final String token = _Env.token;
}
