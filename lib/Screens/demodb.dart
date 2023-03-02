import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DemoDB extends StatelessWidget {
  const DemoDB({super.key});

  static const String routeName = '/demodb_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("category")
            .orderBy('cid')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 197, 215),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(snapshot.data!.docs[index]['cname']),
                      // subtitle: Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(data['cname'].toString()),
                      //     Text(data['date'].toString()),
                      //   ],
                      // ),
                    ),
                  ),
                );
              });
        },
      )),
    );
  }
}