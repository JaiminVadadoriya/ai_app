// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:ai_app/widgets/getSamashaya.dart';
import 'package:ai_app/pages/feedbck.dart';
import 'package:ai_app/pages/statusbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/complain.dart';

class UserProblem extends StatefulWidget {
  @override
  State<UserProblem> createState() => _UserProblemState();
}

class _UserProblemState extends State<UserProblem> {
  // static const String _title = 'Status about complain';
  var email = FirebaseAuth.instance.currentUser!.email;

// documents ids
  List<String> _docIds = [];

  List<Complain> complain = [];

  late Future<void> _initProblemsData;
  @override
  void initState() {
    super.initState();
    _initProblemsData = _initProblems();
  }

  Future<void> _initProblems() async {
    List<String> documentIds = [];
    await FirebaseFirestore.instance
        .collection('problems')
        .where("email", isEqualTo: email)
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
        .where("email", isEqualTo: email)
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

//   Future samashyaHe() async {
// //get the collection
//     setState(() {});
//     await FirebaseFirestore.instance
//         .collection('problems')
//         .where("email", isEqualTo: email)
//         .get()
//         .then(
//           (snapshot) => snapshot.docs.forEach(
//             (document) {
//               docIds.add(document.reference.id);
//             },
//           ),
//         );
//     // CollectionReference samashaya =
//   }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initProblemsData,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
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
                  prototypeItem: ListTile(
                    title: Text("Document Ids"),
                  ),

                  // To make listView scrollable
                  // even if there is only a single item.
                  physics: const AlwaysScrollableScrollPhysics(),

                  itemBuilder: (context, index) {
                    return getSamashya(
                      documentId: _docIds[index],
                    );
                    // return ListTile(
                    //   title: Text(docIds[index]),
                    //   trailing: Icon(Icons.edit),
                    //   // isThreeLine: true,
                    // ),
                  },
                  // );
                  // },

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
                ),
              );
            }
          case ConnectionState.none:
            {
              return Placeholder();
            }
        }
      },
    );
  }
}

Widget getSamashya({required String documentId}) {
  //get the collection
  CollectionReference problem =
      FirebaseFirestore.instance.collection('problems');
  return FutureBuilder(
    future: problem.doc(documentId).get(GetOptions()),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        return ListTile(
          title: Text("${data['problem']}"),
          subtitle: Text("${data['address']}"),
          trailing: FeedBck(
            documentId: documentId,
          ),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Statusbar(
                  problemProcess: data['problemProcess'],
                ),
              ),
            )
          },
          isThreeLine: true,
          // isThreeLine: true,
        );
      }
      return ListTile(
        title: Text("waiting..."),
      );
    },
  );
}
