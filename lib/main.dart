import 'package:ai_app/pages/comForm.dart';
import 'package:ai_app/pages/userMap.dart';
import 'package:ai_app/utils/themes.dart';

import 'pages/login.dart';
import 'pages/sign.dart';
import 'package:flutter/material.dart';
import 'utils/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        //Signup();
        MaterialApp(
      themeMode: ThemeMode.dark,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      // initialRoute: MyRoutes.signRoute,
      initialRoute: "/",
      //initialRoute: MyRoutes.mapRoute,
      // initialRoute: MyRoutes.compRoute,

      routes: {
        "/": (context) => Signup(),
        MyRoutes.signRoute: (context) => Signup(),
        MyRoutes.loginRoute: (context) => Login(),
        MyRoutes.mapRoute: (context) => MyMap(),
        // MyRoutes.compRoute: (context) => ComForm(),
        // MyRoutes.statRoute: (context) => UserHome(),
      },
    );
  }
}
