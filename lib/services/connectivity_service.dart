import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Stream<ConnectivityResult> get connectivity$ =>
      _connectivity.onConnectivityChanged;

  Future<bool> get isOnline async {
    final res = await _connectivity.checkConnectivity();
    return res != ConnectivityResult.none;
  }
}
