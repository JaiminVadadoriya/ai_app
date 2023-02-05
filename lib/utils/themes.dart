import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        // primarySwatch: Colors.indigo,
        // 3F51BE
        colorSchemeSeed: Color(0xFF3F51BE),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        // appBarTheme: AppBarTheme(),
        // appBarTheme: AppBarTheme(
        //   color: Colors.white,
        //   titleTextStyle: TextStyle(
        //     // color: Colors.blue,
        //     color: Theme.of(context).colorScheme.primary,
        //     fontWeight: FontWeight.w500,
        //     fontSize: 20,
        //   ),
        //   elevation: 0.0,
        //   iconTheme: IconThemeData(color: Colors.black),
        //   // textTheme: Theme.of(context).textTheme,
        // ),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      );

  // //Colors
  // static Color creamColor = Color(0xfff5f5f5);
  // static Color darkBluishColor = Color(0xff403b58);
}
