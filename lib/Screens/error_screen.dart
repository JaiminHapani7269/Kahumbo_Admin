import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  static const String routeName = '/error-page';
  final bool isInternetConnected;
  const ErrorScreen({
    this.isInternetConnected = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isInternetConnected
            ? const Text(
                'Error! There is no route here',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.7,
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Please check your Internet Connection, and than try again!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.7,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Try Again!',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}