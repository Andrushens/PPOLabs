import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> isConnected() async {
  var res = await Connectivity().checkConnectivity();
  return res == ConnectivityResult.mobile || res == ConnectivityResult.wifi;
}
