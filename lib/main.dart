import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_configuration/global_configuration.dart';
import 'src/generated/i18n.dart';
import 'src/repository/settings_repository.dart' as settingRepo;
import 'src/repository/user_repository.dart' as userRepo;
import 'src/helpers/app_config.dart' as config;
import 'src/models/setting.dart';
import 'src/route_generator.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset('configurations');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settingRepo.initSettings();
    userRepo.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: settingRepo.setting,
      builder: (context, Setting _setting, _) {
        // print(_setting.toMap());
        return DynamicTheme(
          defaultBrightness: Brightness.light,
          data: (brightness) {
            if (brightness == Brightness.light) {
              return ThemeData(
                fontFamily: 'Scanno',
                primaryColor: config.Colors().mainColor(1),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    elevation: 0, foregroundColor: Colors.white),
                primarySwatch: Colors.blue,
                brightness: brightness,
                // scaffoldBackgroundColor: config.Colors().scaffoldColor(1),
                accentColor: config.Colors().accentColor(1),
                dividerColor: config.Colors().secondColor(0.05),
                focusColor: config.Colors().scaffoldColor(1),
                hintColor: config.Colors().secondColor(1),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 14.0, color: config.Colors().mainColor(1)),
                  bodyText2: TextStyle(
                      fontSize: 14.0, color: config.Colors().secondColor(1)),
                  button: TextStyle(
                      fontSize: 14.0, color: config.Colors().secondColor(1)),
                  subtitle1: TextStyle(
                      fontSize: 16.0, color: config.Colors().secondColor(1)),
                  subtitle2: TextStyle(
                      fontSize: 16.0, color: config.Colors().secondColor(1)),
                  caption: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                      color: config.Colors().secondColor(0.6)),
                ),
              );
            } else {
              return ThemeData(
                fontFamily: 'ProductSans',
                primaryColor: Color(0xFF252525),
                brightness: Brightness.dark,
                scaffoldBackgroundColor: Color(0xFF2C2C2C),
                accentColor: config.Colors().mainDarkColor(1),
                hintColor: config.Colors().secondDarkColor(1),
                focusColor: config.Colors().accentDarkColor(1),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 22.0, color: config.Colors().mainDarkColor(1)),
                  bodyText2: TextStyle(
                      fontSize: 20.0,
                      color: config.Colors().secondDarkColor(1)),
                  caption: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                      color: config.Colors().secondDarkColor(0.6)),
                ),
              );
            }
          },
          themedWidgetBuilder: (context, theme) {
            return MaterialApp(
              navigatorKey: settingRepo.navigatorKey,
              title: _setting.appName,
              initialRoute: '/Splash',
              onGenerateRoute: RouteGenerator.generateRoute,
              debugShowCheckedModeBanner: false,
              locale: _setting.mobileLanguage.value,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              localeListResolutionCallback:
                  S.delegate.listResolution(fallback: const Locale('es', '')),
              theme: theme,
            );
          },
        );
      },
    );
  }
}
