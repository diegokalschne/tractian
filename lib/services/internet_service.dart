import 'package:connectivity_plus/connectivity_plus.dart';

/// Check if the device is connected to wifi or mobile data
Future<bool> hasInternet() async {
  final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();

  return connectivityResult.any((e) => [ConnectivityResult.mobile, ConnectivityResult.wifi].contains(e));
}
