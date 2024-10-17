import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';

class ConnectivityService with WidgetsBindingObserver {
  late Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool isDialogOpen = false;
  bool isConnectedToInternet = true;

  void initialize() async {
    _connectivity = Connectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    WidgetsBinding.instance.addObserver(this);

    // Show toast for initial connectivity status
    var initialConnectivityResult = await _connectivity.checkConnectivity();
    if (initialConnectivityResult == ConnectivityResult.none) {
      isConnectedToInternet = false;
      if (!isDialogOpen) {
        _showNoInternetDialog(navigatorKey.currentContext!);
      }
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    // Handle multiple connectivity results, assuming first result is the most recent.
    ConnectivityResult result =
        results.isNotEmpty ? results.first : ConnectivityResult.none;

    if (result == ConnectivityResult.none) {
      isConnectedToInternet = false;
      if (!isDialogOpen) {
        _showNoInternetDialog(navigatorKey.currentContext!);
      }
    } else {
      isConnectedToInternet = true;
    }
  }

  Future<void> _showNoInternetDialog(BuildContext ctx) async {
    if (!isDialogOpen) {
      isDialogOpen = true;
    }
    return showDialog<void>(
      context: ctx,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'NO INTERNET FOUND',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0XFF000000),
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                SizedBox(
                  height: 80,
                  child: SvgPicture.asset(
                    'assets/images/no_internet.svg',
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'You are not connected to internet. Please check your connection and try again.',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    if (isConnectedToInternet) {
                      isDialogOpen = false;
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0XFF2D73FE),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Retry",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0XFFFFFFFF),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      dispose();
    }
  }

  void dispose() {
    _connectivitySubscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }
}
