import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/services.dart';
import 'generated/i18n.dart';
import 'route_generator.dart';
import 'controllers/controller.dart';
import 'helpers/app_config.dart' as config;
import 'models/setting.dart';
import 'repository/settings_repository.dart' as settingRepo;

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("configurations");
  runApp(MyApp());
}

class MyApp extends AppMVC {
  // This widget is the root of your application.
//  /// Supply 'the Controller' for this application.
  MyApp({Key key}) : super(con: Controller(), key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) {
          if (brightness == Brightness.light) {
            return ThemeData(
              fontFamily: 'ProductSans',
              primaryColor: Colors.white,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  elevation: 0, foregroundColor: Colors.white),
              brightness: brightness,
              accentColor: config.Colors().mainColor(1),
              dividerColor: config.Colors().accentColor(0.05),
              focusColor: config.Colors().accentColor(1),
              hintColor: config.Colors().secondColor(1),
              textTheme: TextTheme(
                headline5: TextStyle(
                    fontSize: 22.0, color: config.Colors().secondColor(1)),
                headline4: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: config.Colors().secondColor(1)),
                headline3: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                    color: config.Colors().secondColor(1)),
                headline2: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: config.Colors().mainColor(1)),
                headline1: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w300,
                    color: config.Colors().secondColor(1)),
                subtitle1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: config.Colors().secondColor(1)),
                headline6: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                    color: config.Colors().mainColor(1)),
                bodyText2: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: config.Colors().secondColor(1)),
                bodyText1: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: config.Colors().secondColor(1)),
                caption: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                    color: config.Colors().accentColor(1)),
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
                headline5: TextStyle(
                    fontSize: 22.0, color: config.Colors().secondDarkColor(1)),
                headline4: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: config.Colors().secondDarkColor(1)),
                headline3: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                    color: config.Colors().secondDarkColor(1)),
                headline2: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: config.Colors().mainDarkColor(1)),
                headline1: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w300,
                    color: config.Colors().secondDarkColor(1)),
                subtitle1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: config.Colors().secondDarkColor(1)),
                headline6: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                    color: config.Colors().mainDarkColor(1)),
                bodyText2: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: config.Colors().secondDarkColor(1)),
                bodyText1: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
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
          return ValueListenableBuilder(
              valueListenable: settingRepo.setting,
              builder: (context, Setting _setting, _) {
                print(_setting.toMap());
                return MaterialApp(
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
                  localeListResolutionCallback: S.delegate
                      .listResolution(fallback: const Locale('en', '')),
                  theme: theme,
                );
              });
        });
  }
}
