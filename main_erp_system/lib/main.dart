import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:main_erp_system/Auth/Login.dart';
import 'package:main_erp_system/dashboard/dashboard.dart';
import 'package:main_erp_system/Auth/Login.dart';
import 'package:main_erp_system/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(const MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en','am']);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);

  runApp(MaterialApp(
    home: email == null ? LoginScreen() : dashboard(),
    title: ".ERP System",
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return LocaleBuilder(
      builder: (Locale) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ".ERP System",
        localizationsDelegates: Locales.delegates,
        supportedLocales: Locales.supportedLocales,
        locale: Locale,
        theme: ThemeData(
          primarySwatch: buildMaterialColor(Color(0xFF5048E5)),
        ),
        home: LoginScreen(
            //body: LoginScreen(),
            ),
      ),
    );
  }
}
