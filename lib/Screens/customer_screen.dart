import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahumbo_admin/Constants/app_colors.dart';

import '../Constants/dimentions.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  static const String routeName = '/customer_screen';

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:const Text("Customers"),
        centerTitle: true,
        backgroundColor: AppColors.mainPurple,
        elevation: 0.0,
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('customer').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No Customer',
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
                      title: Column(
                        children: [
                          Row(
                            
                            children: [
                              const Icon(Icons.person,color:Colors.green),
                            const  SizedBox(width: 10.0,),
                              Text(data['c_name'],style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: AppColors.mainPurple),), 
                            ],
                          ),
                          const SizedBox(height: 5.0,),
                          Row(
                            children: [
                             const Icon(Icons.call,color:Colors.green),
                             const SizedBox(width: 10.0,),
                              Text(data['mobile'],style:const TextStyle(fontSize: 18),),
                      ],
                    ),
                        ],
                      ), 
                    ),
                  ),
                );
              });
        },
      )),
      );
    
  }
}
