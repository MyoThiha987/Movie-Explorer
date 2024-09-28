import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class ConnectionChecker {
  Future<bool> get isConnected;
}

class ConnectionCheckerImpl extends ConnectionChecker {
  final InternetConnection internetConnectionChecker;

  ConnectionCheckerImpl({required this.internetConnectionChecker});

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasInternetAccess;
}
