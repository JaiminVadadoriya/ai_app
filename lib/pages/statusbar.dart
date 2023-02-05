// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Statusbar extends StatefulWidget {
  final String? problemProcess;
  const Statusbar({
    Key? key,
    required this.problemProcess,
  }) : super(key: key);

  @override
  State<Statusbar> createState() => _StatusbarState();
}

class _StatusbarState extends State<Statusbar> {
  // Step Counter
  int current_step = 0;

  List<Step> examples = [
    Step(
      title: Text('Step 1'),
      content: Text('Hello!'),
      isActive: true,
    ),
    Step(
      title: Text('Step 2'),
      content: Text('World!'),
      isActive: true,
    ),
    Step(
      title: Text('Step 3'),
      content: Text('Hello World!'),
      state: StepState.complete,
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    IndicatorStyle indiCompleted = IndicatorStyle(
      width: 25,
      indicatorXY: .5,
      // padding: EdgeInsets.all(8.0),
      color: Theme.of(context).primaryColor,
      iconStyle: IconStyle(
        fontSize: 17,
        color: Colors.white,
        iconData: Icons.check,
      ),
    );
    IndicatorStyle indiProcess = IndicatorStyle(
      width: 25,
      indicatorXY: .5,
      // padding: EdgeInsets.all(8.0),
      color: Theme.of(context).primaryColor,
      iconStyle: IconStyle(
        fontSize: 17,
        color: Colors.white,
        iconData: Icons.loop_rounded,
      ),
    );
    // IndicatorStyle indiNotComplete = IndicatorStyle(
    //   width: 20,
    //   indicatorXY: .5,
    //   padding: EdgeInsets.all(8.0),
    //   color: Theme.of(context).primaryColor,
    //   iconStyle: IconStyle(
    //     fontSize: 15,
    //     color: Colors.white,
    //     iconData: Icons.loop_rounded,
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Problem Status"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: .1,
            isFirst: true,
            afterLineStyle: LineStyle(color: Theme.of(context).primaryColor),
            indicatorStyle: indiCompleted,
            endChild: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Register Complain",
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: .1,
            afterLineStyle: LineStyle(
              color: Theme.of(context).primaryColor,
            ),
            beforeLineStyle: LineStyle(
              color: Theme.of(context).primaryColor,
            ),
            indicatorStyle: indiCompleted,
            endChild: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Complain Confirmed",
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: .1,
            afterLineStyle: LineStyle(
              color: Theme.of(context).primaryColor,
            ),
            beforeLineStyle: LineStyle(
              color: Theme.of(context).primaryColor,
            ),
            indicatorStyle: indiProcess,
            endChild: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Complain Processed",
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: .1,
            hasIndicator: false,
          ),
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: .1,
            isLast: true,
            endChild: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Complain Solved",
                style: TextStyle(
                  fontSize: 20,
                  // color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // Container(
    //   decoration: const BoxDecoration(
    //     gradient: LinearGradient(
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //       colors: [
    //         Color(0xFF004E92),
    //         Color(0xFF000428),
    //       ],
    //     ),
    //   ),
    //   child: SafeArea(
    //     child:
    //   ),
    // );
  }
}

// class _IndicatorExample extends StatelessWidget {
//   const _IndicatorExample({Key? key, required this.number}) : super(key: key);

//   final String number;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.fromBorderSide(
//           BorderSide(
//             color: Colors.white.withOpacity(0.2),
//             width: 4,
//           ),
//         ),
//       ),
//       child: Center(
//         child: Text(
//           number,
//           style: const TextStyle(fontSize: 30),
//         ),
//       ),
//     );
//   }
// }

// class _RowExample extends StatelessWidget {
//   const _RowExample({Key? key, required this.example}) : super(key: key);

//   final Example example;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: Text(
//               example.name,
//               style: GoogleFonts.jura(
//                 color: Colors.white,
//                 fontSize: 18,
//               ),
//             ),
//           ),
//           const Icon(
//             Icons.navigate_next,
//             color: Colors.white,
//             size: 26,
//           ),
//         ],
//       ),
//     );
//   }
// }
