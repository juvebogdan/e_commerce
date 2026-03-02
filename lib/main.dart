import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/services/locator.dart';
import 'package:shop_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shop_app/size_config.dart'; // Add this import
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (kDebugMode) {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (_) {
      // Ignore auth errors in debug bypass
    }
  }
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      initialRoute: kDebugMode ? HomeScreen.routeName : SplashScreen.routeName,
      routes: routes,
      builder: (context, child) {
        SizeConfig.init(context);
        return child!;
      },
    );
  }
}
