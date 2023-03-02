import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kahumbo_admin/Screens/home_screen.dart';
import 'package:kahumbo_admin/Screens/login_screen.dart';

import '../Constants/app_colors.dart';
import '../Constants/dimentions.dart';
import '../Helper/helper_function.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogIn = false;

  @override
  void initState() {
    super.initState();
    getLoggedInState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(
            context, isLogIn ? HomeScreen.routeName : LoginPage.routeName));
  }

  getLoggedInState() async {
    await HelperFunction.getLoginData().then((logInStatus) {
      setState(() {
        isLogIn = logInStatus!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        color: AppColors.mainPurple,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset("assets/images/logo-white.svg"),
          ),
        ),
      ),
    );
  }
}
