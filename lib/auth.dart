import "package:formularz_snu_client/formularz_snu_client.dart";

class SimpleAuthManager extends AuthenticationKeyManager {
  SimpleAuthManager(this._key);
  String? _key;

  @override
  Future<String?> get() async {
    return _key;
  }

  @override
  Future<void> put(String key) async {
    _key = key;
  }

  @override
  Future<void> remove() async {
    _key = null;
  }

  @override
  Future<String?> toHeaderValue(String? key) async {
    if (key == null) return null;
    return "Bearer $key";
  }
}
