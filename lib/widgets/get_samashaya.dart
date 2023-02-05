import 'package:ai_app/models/complain.dart';
import 'package:ai_app/pages/info_problem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetSamashya extends StatelessWidget {
  final String documentId;
  const GetSamashya({super.key, required this.documentId});

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
          return ListTile(
            title: Text(
                "${complain.problem} - ${complain.complainTime?.toDate()}"),
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
        return ListTile(
          title: Text("waiting..."),
        );
      },
    );
  }
}
