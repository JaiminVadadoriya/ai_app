// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../models/complain.dart';

class UserHome extends StatelessWidget {
  static const String _title = 'Status about complain';
  final List<Complain> allComplain;
  const UserHome({
    Key? key,
    required this.allComplain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Container(
            child: ListView.builder(
          itemCount: allComplain.length,
          prototypeItem: ListTile(
            title: Text(allComplain[0].problem),
            subtitle: Text(allComplain[0].address),
            trailing: Icon(Icons.edit),
            isThreeLine: true,
          ),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(allComplain[index].problem),
              subtitle: Text(
                  "${allComplain[index].address}-${allComplain[index].pincode}"),
              trailing: Icon(Icons.edit),
              isThreeLine: true,
            );
          },
        )
            //  ListView(
            //   children: const <Widget>[
            //     Card(
            //       child: ListTile(
            //         // leading: FlutterLogo(size: 72.0),
            //         title: Text('Street Light'),
            //         subtitle: Text('near krish flat,Nikol gam, Amdavad - 382350'),
            //         trailing: Icon(Icons.edit),
            //         isThreeLine: true,
            //       ),
            //     ),
            //     Card(
            //       child: ListTile(
            //         // leading: FlutterLogo(size: 72.0),
            //         title: Text('Road'),
            //         subtitle: Text(
            //             'Vrindavan Society, Bapu Nagar, Ahmedabad  - 382160'),
            //         trailing: Icon(Icons.edit),
            //         isThreeLine: true,
            //       ),
            //     ),
            //   ],
            // ),
            ),
      ),
    );
  }
}
