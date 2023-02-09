// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_app/widgets/get_samashaya.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/complain.dart';

class AllProblem extends StatefulWidget {
  static const String _title = 'Status about complain';

  @override
  State<AllProblem> createState() => _AllProblemState();
}

class _AllProblemState extends State<AllProblem> {
  late Future _initProblemsData;
  @override
  void initState() {
    super.initState();
    _initProblemsData = _initProblems();
  }

  // final List<Complain> allComplain;
  List<String> _docIds = [];

  List<Complain> complain = [];

  Future<void> _initProblems() async {
    List<String> documentIds = [];
    await FirebaseFirestore.instance
        .collection('problems')
        .where(
          "problemProcess",
          isNotEqualTo: "completed",
        )
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              documentIds.add(document.reference.id);
            },
          ),
        );

    _docIds = documentIds;
  }

  Future<void> _refreshProblems() async {
    List<String> documentIds = [];
    await FirebaseFirestore.instance
        .collection('problems')
        .where(
          "problemProcess",
          isNotEqualTo: "completed",
        )
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              documentIds.add(document.reference.id);
            },
          ),
        );
    setState(() {
      _docIds = documentIds;
    });
  }

//   Future<List<String>> samashyaHe() async {
// //get the collection
//     List<String> documentIds = [];
//     await FirebaseFirestore.instance.collection('problems').get().then(
//           (snapshot) => snapshot.docs.forEach(
//             (document) {
//               documentIds.add(document.reference.id);
//             },
//           ),
//         );
//     return documentIds;
//     // CollectionReference samashaya =
//   }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initProblemsData,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            {
              return Center(
                child: Text('Loading...'),
              );
            }
          case ConnectionState.done:
            {
              return RefreshIndicator(
                onRefresh: _refreshProblems,
                child: ListView.builder(
                  itemCount: _docIds.length,
                  prototypeItem: Container(
                    height: 90,
                    width: double.infinity,
                  ),
                  itemBuilder: (context, index) {
                    return GetSamashya(
                      documentId: _docIds[index],
                    );
                    // return ListTile(
                    //   title: Text(docIds[index]),
                    //   trailing: Icon(Icons.edit),
                    //   // isThreeLine: true,
                    // );
                  },
                ),
              );
            }
        }
      },
    );
  }
}


      //     child: ListView.builder(
      //   itemCount: allComplain.length,
      //   prototypeItem: ListTile(
      //     title: Text(allComplain[0].problem! + ""),
      //     subtitle: Text(allComplain[0].address!),
      //     trailing: Icon(Icons.edit),
      //     isThreeLine: true,
      //   ),
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       title: Text(allComplain[index].problem!),
      //       subtitle: Text(
      //           "${allComplain[index].address}-${allComplain[index].pincode}"),
      //       trailing: Icon(Icons.edit),
      //       isThreeLine: true,
      //     );
      //   },
      // )
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