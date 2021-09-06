import 'package:carwash_adm/src/pages/home_page.dart';
import 'package:carwash_adm/src/pages/login_page.dart';
import 'package:flutter/material.dart';

// import 'models/route_argument.dart';
import 'models/route_argument.dart';
import 'pages/splash_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashPage());
      case '/Login':
        return MaterialPageRoute(builder: (_) => SigninPage());
      case '/Home':
        return MaterialPageRoute(builder: (_) => HomePage());
      // case '/Tracking':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           TrackingWidget(routeArgument: args as RouteArgument));

      // case '/Cart':
      //   return MaterialPageRoute(
      //       builder: (_) => CartPage(routeArgument: args as RouteArgument));
      // case '/OrderSuccess':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           OrderSuccessPage(routeArgument: args as RouteArgument));
      // case '/PedidoConfirmation':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           PedidoConfirmationPage(routeArgument: args as RouteArgument));
      // case '/PagoConfirmation':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           PagoConfirmationPage(routeArgument: args as RouteArgument));
      // case '/PagoSuccess':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           PagoSuccessPage(routeArgument: args as RouteArgument));
      // case '/Contactanos':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           ContactanosPage(routeArgument: args as RouteArgument));
      // case '/TerminoUso':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           TerminoUsoPage(routeArgument: args as RouteArgument));
      // case '/PoliticasPrivacidad':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           PoliticasPrivacidadPage(routeArgument: args as RouteArgument));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(body: SizedBox(height: 0)));
    }
  }
}
