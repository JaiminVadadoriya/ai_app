import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedBck extends StatelessWidget {
  final String documentId;

  const FeedBck({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference problem =
        FirebaseFirestore.instance.collection('problems');

    return IconButton(
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
        icon: Icon(Icons.delete));
  }
}
