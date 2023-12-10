import 'package:flutter/material.dart';

import '../../utils/shared_storage.dart';

class AnimationNavigation {

  static Future slidePush(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = SharedStorage.getLanguage() == "en"
              ? const Offset(1.0, 0.0)
              : const Offset(-1.0, 0.0);
          var end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          var curveAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.linear,
            reverseCurve: Curves.easeInOutCubicEmphasized,
          );
          return SlideTransition(
            position: tween.animate(curveAnimation),
            child: child,
          );
        },
      ),
    );
  }

  static Future scalePush(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = SharedStorage.getLanguage() == "en" ? 1.0 : 0.0;
          var end = SharedStorage.getLanguage() == "en" ? 0.0 : 1.0;
          final tween = Tween(begin: begin, end: end);
          var curveAnimation = CurvedAnimation(
            parent: animation.drive(tween),
            curve: Curves.linear,
            reverseCurve: Curves.easeInOutCubic,
          );
          return ScaleTransition(
            scale: tween.animate(curveAnimation),
            child: child,
          );
        },
      ),
    );
  }

  static Future rotatePush(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = SharedStorage.getLanguage() == "en" ? 1.0 : 0.0;
          var end = SharedStorage.getLanguage() == "en" ? 0.0 : 1.0;
          final tween = Tween(begin: begin, end: end);
          var curveAnimation = CurvedAnimation(
            parent: animation.drive(tween),
            curve: Curves.linear,
            reverseCurve: Curves.easeInOutCubic,
          );
          return RotationTransition(
            turns: tween.animate(curveAnimation),
            child: child,
          );
        },
      ),
    );
  }

  static Future sizePush(
    BuildContext context,
    Widget page, {
    var alignment = Alignment.center,
  }) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return Align(
            alignment: alignment,
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  static Future fadePush(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }





  static Future slidePushReplacement(BuildContext context, Widget page) {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = SharedStorage.getLanguage() == "en"
              ? const Offset(1.0, 0.0)
              : const Offset(-1.0, 0.0);
          var end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          var curveAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.linear,
            reverseCurve: Curves.easeInOutCubicEmphasized,
          );
          return SlideTransition(
            position: tween.animate(curveAnimation),
            child: child,
          );
        },
      ),
    );
  }

  static Future scalePushReplacement(BuildContext context, Widget page) {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = SharedStorage.getLanguage() == "en" ? 1.0 : 0.0;
          var end = SharedStorage.getLanguage() == "en" ? 0.0 : 1.0;
          final tween = Tween(begin: begin, end: end);
          var curveAnimation = CurvedAnimation(
            parent: animation.drive(tween),
            curve: Curves.linear,
            reverseCurve: Curves.easeInOutCubic,
          );
          return ScaleTransition(
            scale: tween.animate(curveAnimation),
            child: child,
          );
        },
      ),
    );
  }

  static Future rotatePushReplacement(BuildContext context, Widget page) {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = SharedStorage.getLanguage() == "en" ? 1.0 : 0.0;
          var end = SharedStorage.getLanguage() == "en" ? 0.0 : 1.0;
          final tween = Tween(begin: begin, end: end);
          var curveAnimation = CurvedAnimation(
            parent: animation.drive(tween),
            curve: Curves.linear,
            reverseCurve: Curves.easeInOutCubic,
          );
          return RotationTransition(
            turns: tween.animate(curveAnimation),
            child: child,
          );
        },
      ),
    );
  }

  static Future sizePushReplacement(
    BuildContext context,
    Widget page, {
    var alignment = Alignment.center,
  }) {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return Align(
            alignment: alignment,
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  static Future fadePushReplacement(BuildContext context, Widget page) {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }






  static Future slidePushAndRemoveUntil(BuildContext context, Widget page) {
    return Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = SharedStorage.getLanguage() == "en"
              ? const Offset(1.0, 0.0)
              : const Offset(-1.0, 0.0);
          var end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          var curveAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.linear,
            reverseCurve: Curves.easeInOutCubicEmphasized,
          );
          return SlideTransition(
            position: tween.animate(curveAnimation),
            child: child,
          );
        },
      ),
      (Route<dynamic> route) => false,
    );
  }

  static Future scalePushAndRemoveUntil(BuildContext context, Widget page) {
    return Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = SharedStorage.getLanguage() == "en" ? 1.0 : 0.0;
          var end = SharedStorage.getLanguage() == "en" ? 0.0 : 1.0;
          final tween = Tween(begin: begin, end: end);
          var curveAnimation = CurvedAnimation(
            parent: animation.drive(tween),
            curve: Curves.linear,
            reverseCurve: Curves.easeInOutCubic,
          );
          return ScaleTransition(
            scale: tween.animate(curveAnimation),
            child: child,
          );
        },
      ),
      (Route<dynamic> route) => false,
    );
  }

  static Future rotatePushAndRemoveUntil(BuildContext context, Widget page) {
    return Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = SharedStorage.getLanguage() == "en" ? 1.0 : 0.0;
          var end = SharedStorage.getLanguage() == "en" ? 0.0 : 1.0;
          final tween = Tween(begin: begin, end: end);
          var curveAnimation = CurvedAnimation(
            parent: animation.drive(tween),
            curve: Curves.linear,
            reverseCurve: Curves.easeInOutCubic,
          );
          return RotationTransition(
            turns: tween.animate(curveAnimation),
            child: child,
          );
        },
      ),
      (Route<dynamic> route) => false,
    );
  }

  static Future sizePushAndRemoveUntil(
    BuildContext context,
    Widget page, {
    var alignment = Alignment.center,
  }) {
    return Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return Align(
            alignment: alignment,
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
            ),
          );
        },
      ),
      (Route<dynamic> route) => false,
    );
  }

  static Future fadePushAndRemoveUntil(BuildContext context, Widget page) {
    return Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
      (Route<dynamic> route) => true,
    );
  }




}
