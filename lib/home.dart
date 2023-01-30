import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      // MapMun(
      //     cameraTarget: cameraTarget,
      //     dekhBinod: () => {
      //           dekhBinod(),
      //         }),
      // ProblmMun(),
    ];
    return Scaffold(
      appBar: AppBar(
        // on below line we have given title of app
        title: Text("GFG"),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      // on pressing floating action button the camera will take to user current location
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              // onPressed: dekhBinod,
              onPressed: null,
              child: Icon(Icons.location_searching),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedIconTheme: IconThemeData(
          color: Colors.black87,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Problems',
            backgroundColor: Colors.transparent,
            // backgroundColor: Colors.green,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.school),
          //   label: 'School',
          //   backgroundColor: Colors.purple,
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings),
          //   label: 'Settings',
          //   backgroundColor: Colors.pink,
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 0, 90, 53),
        onTap: _onItemTapped,
      ),
    );
  }
}
