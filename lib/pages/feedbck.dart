import 'package:ai_app/models/complain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedBck extends StatelessWidget {
  final String? documentId;

  const FeedBck({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference problem =
        FirebaseFirestore.instance.collection('problems');

    //

    return Scaffold(
      appBar: AppBar(
        title: Text("Problem"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Complain complain = Complain.fromFirestore(
                    snapshot.data! as DocumentSnapshot<Map<String, dynamic>>,
                    SnapshotOptions());
                if (complain.email == null) {
                  Navigator.pop(context);
                }
                // Map<String, dynamic> data =
                //     snapshot.data!.data() as Map<String, dynamic>;

                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        width: double.infinity,
                        child: Text(
                          "${complain.problem}",
                          style: TextStyle(
                            fontSize: 26,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Address:",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text("${complain.address}"),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(),
                      Text(
                        "Time:",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text("${complain.complainTime?.toDate()}"),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(),
                      Text(
                        "Description:",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text("${complain.description}"),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(),
                      Text(
                        "Problem Location:",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                          "[ ${complain.problemLocation?.latitude} - ${complain.problemLocation?.longitude} ]"),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(),
                      Text(
                        "Process:",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text("${complain.problemProcess}"),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(),
                      Text(
                        "Pincode:",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Text("${complain.pincode}"),
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Delete Problem'),
                                  content: const Text(
                                    'Are you Sure your complain is completed?',
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        //delete from collection
                                        problem.doc(documentId).delete();
                                        //pop from dialog
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                ),
                              );
                              Navigator.pop(context);
                            },
                            child: Text("complete"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("not complete"),
                          ),
                        ],
                      )
                    ],
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
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            future: problem.doc(documentId).get(),
          ),
        ],
      ),
    );
  }
}
