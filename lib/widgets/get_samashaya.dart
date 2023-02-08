// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:ai_app/models/complain.dart';
import 'package:ai_app/pages/info_problem.dart';
import 'package:ai_app/utils/get_time_ago.dart';

class GetSamashya extends StatelessWidget {
  final String documentId;
  const GetSamashya({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference problem =
        FirebaseFirestore.instance.collection('problems');

    return FutureBuilder(
      future: problem.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Complain complain = Complain.fromFirestore(
              snapshot.data! as DocumentSnapshot<Map<String, dynamic>>,
              SnapshotOptions());
          // Map<String, dynamic> data =
          //     snapshot.data!.data() as Map<String, dynamic>;

          return Material(
            // elevation: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text(
                        '12',
                      ),
                    ),
                  ),
                ),
                title: Text(
                    "${complain.problem} - ${TimeAgo.getTimeAgo(complain.complainTime?.millisecondsSinceEpoch as int)}"),
                subtitle: Text("${complain.address}"),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InfoProblem(complain: complain),
                      ))
                },
                // trailing: IconButton(
                //   icon: Icon(Icons.edit),
                //   onPressed: () {},
                // ),

                isThreeLine: true,
                // isThreeLine: true,
              ),
            ),
          );
          // return ListTile(
          //   title: Text("${data['problem']}"),
          //   subtitle: Text("${data['address']}"),
          //   onTap: () => {},
          //   // trailing: IconButton(
          //   //   icon: Icon(Icons.edit),
          //   //   onPressed: () {},
          //   // ),

          //   isThreeLine: true,
          //   // isThreeLine: true,
          // );
        }
        return Text("waiting");
      },
    );
  }
}
