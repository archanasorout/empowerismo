import 'package:empowerismo/src/dashboard/home_page.dart';
import 'package:empowerismo/utils/UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'base/constants/PrefConstant.dart';
import 'package:empowerismo/src/authentication/login_page.dart';
import 'language/demo_localizations_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final status = await isUserLogin();
  runApp(MyApp(status: status,));
}

class MyApp extends StatelessWidget {
  final status;
   MyApp( {this.status, });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        const Locale('tr', 'TR'),
        const Locale('en', 'US')
      ],
      localizationsDelegates: [
        const DemoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode || supportedLocale.countryCode == locale.countryCode) {
    return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      title: 'empowerismo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: status ? HomePage(1) : LoginPage(),
    );
  }
}

Future<bool> isUserLogin() async {
  UserRepo userRepo = UserRepo();
  var value = await userRepo.getPrefrenceData(
    defaultValue: true,
    key: PrefConstant.USER_LOGIN,
  );
  return value == null ? false : value;
}


