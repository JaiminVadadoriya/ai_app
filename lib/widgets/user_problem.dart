// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:ai_app/widgets/getSamashaya.dart';
import 'package:ai_app/pages/feedbck.dart';
import 'package:ai_app/pages/statusbar.dart';
import 'package:ai_app/utils/notification_api.dart';
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

  late Future<void> _initProblemsData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initProblemsData = _initProblems();

    NotificationApi.initState();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotification.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FeedBck(documentId: payload),
      ),
    );
  }

// documents ids
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
        .where("email", isEqualTo: email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              documentIds.add(document.reference.id);
            },
          ),
        );
    List<String> completedIds = [];
    await FirebaseFirestore.instance
        .collection('problems')
        .where(
          "problemProcess",
          isEqualTo: "completed",
        )
        .where("email", isEqualTo: email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              completedIds.add(document.reference.id);
            },
          ),
        );
    for (var i = 0; i < completedIds.length; i++) {
      Future.delayed(const Duration(seconds: 1), () {
        // Prints after 1 second.
        NotificationApi.showNotification(
          title: 'hey',
          body: 'hey check if your problem was completed or not!!!',
          payload: '${completedIds[i]}',
          // scheduledDate: DateTime.now().add(
          //   Duration(
          //     seconds: 12,
          //   ),
          // ),
        );
      });
    }
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
                child: CircularProgressIndicator(),
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
                      context: context,
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
              return Text("none");
            }
        }
      },
    );
  }
}

Widget getSamashya(
    {required String documentId, required BuildContext context}) {
  //get the collection
  CollectionReference problem =
      FirebaseFirestore.instance.collection('problems');
  return FutureBuilder(
    future: problem.doc(documentId).get(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        return
            // Card(
            //   margin: EdgeInsets.symmetric(
            //     horizontal: 3,
            //     vertical: 0,
            //   ),
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(35)),
            //   ),
            //   elevation: 10,
            //   child: Center(
            //     // alignment: Alignment.center,
            //     // transformAlignment: Alignment.center,
            //     child: Container(
            //       height: 100,
            //       // padding: const EdgeInsets.fromLTRB(1, 0, 1, ),
            // child:
            Material(
          elevation: 7,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            title: Text("${data['problem']}"),
            subtitle: Text("${data['address']}"),
            trailing: IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Delete Problem'),
                  content: const Text('This will delete your problem!!!'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        //delete from collection
                        problem.doc(documentId).delete();
                        //pop from dialog
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Icon(Icons.delete),
              ),
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
          ),
        );
      }
      return ListTile(
        title: Text("waiting..."),
      );
    },
  );
}
