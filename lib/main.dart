import 'package:ai_app/pages/home.dart';
import 'package:ai_app/pages/com_form.dart';
import 'package:ai_app/utils/notification_api.dart';
import 'package:ai_app/widgets/all_problem.dart';
import 'package:ai_app/utils/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';

import 'pages/loginpages/for_otp.dart';
import 'pages/loginpages/login.dart';
import 'pages/loginpages/mobile_for_otp.dart';
import 'pages/loginpages/sign.dart';
import 'package:flutter/material.dart';
import 'utils/routes.dart';

void main() async {
  // debugRepaintRainbowEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationApi.configureLocalTimeZone();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        //Signup();
        MaterialApp(
      themeMode: ThemeMode.light,
      // theme: MyTheme.lightTheme,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      // initialRoute: MyRoutes.signRoute,

      initialRoute: "/",
      // initialRoute: (isSignIn ? "/" : MyRoutes.loginRoute),
      //initialRoute: MyRoutes.mapRoute,
      // initialRoute: MyRoutes.compRoute,

      routes: {
        "/": (context) =>
            ((FirebaseAuth.instance.currentUser != null) ? Home() : Login()),
        MyRoutes.signRoute: (context) => Signup(),
        MyRoutes.loginRoute: (context) => Login(),
        MyRoutes.homeRoute: (context) => Home(),
        MyRoutes.mobileRoute: (context) => MobileForOtp(),
        MyRoutes.otpRoute: (context) => ForOtp(),
        MyRoutes.compRoute: (context) => const ComForm(),
        MyRoutes.statRoute: (context) => AllProblem(),
      },
    );
  }
}
