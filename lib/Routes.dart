import 'package:flutter/material.dart';
import './utils/utils.dart';

import 'Screens/screens.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteName.INITIAL:
        return MaterialPageRoute<dynamic>(
            builder: (_) => Login(), settings: settings);
        break;
      case PageRouteName.SIGNUP:
        return MaterialPageRoute<dynamic>(
            builder: (_) => Signup(), settings: settings);
        break;
      case PageRouteName.CAMERA:
        return MaterialPageRoute<dynamic>(
            builder: (_) => Camera(), settings: settings);
        break;
      case PageRouteName.LOCAL_IMAGE:
        return MaterialPageRoute<dynamic>(
            builder: (_) => LocalImage(), settings: settings);
        break;
      default:
        return MaterialPageRoute<dynamic>(
            builder: (_) => Login(), settings: settings);
    }
  }
}
