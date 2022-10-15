import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  static const String _title = 'Status about complain';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Container(
            child: ListView(
          children: const <Widget>[
            Card(
              child: ListTile(
                // leading: FlutterLogo(size: 72.0),
                title: Text('Street Light'),
                subtitle: Text('near krish flat,Nikol gam, Amdavad - 382350'),
                trailing: Icon(Icons.edit),
                isThreeLine: true,
              ),
            ),
            Card(
              child: ListTile(
                // leading: FlutterLogo(size: 72.0),
                title: Text('Road'),
                subtitle:
                    Text('Vrindavan Society, Bapu Nagar, Ahmedabad  - 382160'),
                trailing: Icon(Icons.edit),
                isThreeLine: true,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
