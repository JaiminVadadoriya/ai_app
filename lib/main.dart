// import 'package:ai_app/pages/comForm.dart';
import 'package:ai_app/pages/forOtp.dart';
import 'package:ai_app/pages/mobileForOtp.dart';
import 'package:ai_app/pages/userMap.dart';
import 'package:ai_app/utils/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/login.dart';
import 'pages/sign.dart';
import 'package:flutter/material.dart';
import 'utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
            ((FirebaseAuth.instance.currentUser != null) ? MyMap() : Login()),
        MyRoutes.signRoute: (context) => Signup(),
        MyRoutes.loginRoute: (context) => Login(),
        MyRoutes.mapRoute: (context) => MyMap(),
        MyRoutes.mobileRoute: (context) => MobileForOtp(),
        MyRoutes.otpRoute: (context) => ForOtp(),
        // MyRoutes.compRoute: (context) => ComForm(),
        // MyRoutes.statRoute: (context) => UserHome(),
      },
    );
  }
}
