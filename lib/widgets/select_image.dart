import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SelectImage extends StatelessWidget {
  const SelectImage({super.key, required this.problem});
  final String? problem;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      radius: 40,
      child: Padding(
        padding: EdgeInsets.all(6),
        child: FittedBox(
          child: (problem == "Road")
              ? Image.asset(
                  'assets/images/road_color.png',
                  width: 40,
                  // width: 300,
                  // height: double.infinity,
                  // width: double.infinity * .5,
                )
              : (problem == "Street Light")
                  ? Image.asset(
                      'assets/images/street_lamp_color.png',
                      width: 40,
                      // width: 300,
                      // height: double.infinity,
                      // width: double.infinity * .5,
                    )
                  : (problem == "Garbage Collection")
                      ? Image.asset(
                          'assets/images/garbage_color.png',
                          width: 40,
                          // width: 300,
                          // height: double.infinity,
                          // width: double.infinity * .5,
                        )
                      : Image.asset(
                          'assets/images/No_connection.png',
                          width: 40,
                          // width: 300,
                          // height: double.infinity,
                          // width: double.infinity * .5,
                        ),
          // Garbage Collection
        ),
      ),
    );
  }
}
