import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/app_colors.dart';
import '../Constants/dimentions.dart';

class FeedbackAdmin extends StatefulWidget {
  const FeedbackAdmin({Key? key}) : super(key: key);

  static const String routeName = '/feedback_screen';

  @override
  State<FeedbackAdmin> createState() => _FeedbackAdminState();
}

class _FeedbackAdminState extends State<FeedbackAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColors.mainPurple,
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('feedback').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No Feedback',
                style: TextStyle(
                    color: AppColors.mainPurple, fontSize: Dimensions.h15),
              ),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                return Padding(
                  padding: EdgeInsets.all(Dimensions.h10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFECE6E9),
                      borderRadius: BorderRadius.circular(Dimensions.r12),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        CupertinoIcons.chat_bubble,
                        color: AppColors.mainPurple,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data['cname']),
                          Text(data['date']),
                        ],
                      ),
                      subtitle: Text(data['msg']),
                    ),
                  ),
                );
              });
        },
      )),
    );
  }
}
