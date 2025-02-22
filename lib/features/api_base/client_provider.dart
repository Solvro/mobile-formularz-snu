import "package:formularz_snu_client/formularz_snu_client.dart";
import "package:serverpod_flutter/serverpod_flutter.dart";

class ClientProvider {
  static final ClientProvider instance = ClientProvider.internal();

  factory ClientProvider() => instance;

  late final Client clientInstance;

  ClientProvider.internal() {
    clientInstance = Client("https://api.formularz-snu.s.solvro.pl/")
  ..connectivityMonitor = FlutterConnectivityMonitor();
  }
  
  Client get client => clientInstance;
  
}
