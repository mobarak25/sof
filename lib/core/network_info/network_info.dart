import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/widgets/no_internet_connection.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  checkInternetConnection(IFlutterNavigator navigator);
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  const NetworkInfoImpl(this.internetConnectionChecker);

  final InternetConnectionChecker internetConnectionChecker;

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;

  @override
  checkInternetConnection(IFlutterNavigator navigator) async {
    bool? dialogue;
    if (!await isConnected && !(dialogue ?? false)) {
      dialogue = true;
      showNoInternetConnection(navigator, dismiss: (value) {
        if (value) dialogue = false;
      });
    }
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      //========ConnectivityResult old was not list
      bool isDeviceConnected = await isConnected;
      if (!isDeviceConnected && !(dialogue ?? false)) {
        dialogue = true;
        showNoInternetConnection(navigator, dismiss: (value) {
          if (value) dialogue = false;
        });
      } else if (dialogue != null) {
        if (dialogue!) {
          navigator.pop();
          dialogue = false;
        }
        ShowSnackBar(
            navigator: navigator, message: 'Internet connection established');
      }
    });
  }
}
