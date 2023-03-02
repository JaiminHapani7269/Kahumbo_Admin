
import 'package:flutter/material.dart';
import 'package:kahumbo_admin/Screens/category.dart';
import 'package:kahumbo_admin/Screens/customer_screen.dart';
import 'package:kahumbo_admin/Screens/feedback.dart';
import 'package:page_transition/page_transition.dart';
import '../Screens/error_screen.dart';
import '../Screens/login_screen.dart';
import '../Screens/order_screen.dart';
import '../Screens/pop_product_admin.dart';
import '../Screens/splash_screen.dart';


class ScreenRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case LoginPage.routeName:
        return PageTransition(
          child: const LoginPage(),
          type: PageTransitionType.rightToLeft,
        );
      case CategoryAdmin.routeName:
        return PageTransition(
          child: const CategoryAdmin(),
          type: PageTransitionType.rightToLeft,
        );
      case CustomerScreen.routeName:
        return PageTransition(
          child: const CustomerScreen(),
          type: PageTransitionType.leftToRight,
        );
      case FeedbackAdmin.routeName:
        return PageTransition(
          child: const FeedbackAdmin(),
          type: PageTransitionType.leftToRight,
        );
      case MyOrderPage.routeName:
        return PageTransition(
          child: const MyOrderPage(),
          type: PageTransitionType.leftToRight,
        );
      case PopAdmin.routeName:
        return PageTransition(
          child: const PopAdmin(),
          type: PageTransitionType.leftToRight,
      );
      default:
        return PageTransition(
          child:const ErrorScreen(),
          type: PageTransitionType.rightToLeft,
        );
    }
  }
}