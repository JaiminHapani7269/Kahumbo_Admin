import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Constants/app_colors.dart';
import '../Constants/dimentions.dart';
import 'order_detail_page.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

  static const String routeName = '/order_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainPurple,
          centerTitle: true,
          title: const Text(
            "Orders",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('order')
              // .where('cid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'Empty Order List',
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
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OrderDetailsPage(
                                  oid: data['oid'],
                                  name: data['cname'],
                                  phone: data['phone'],
                                  product: data['products'],
                                  date: data['date'],
                                  hno: data['houseNo'],
                                  address: data['address'],
                                  area: data['area'],
                                  city: data['city'],
                                  state: data['state'],
                                  pincode: data['pincode'],
                                  total: data['total'],
                                  orderstatus: data['orderStatus'])));
                        },
                        // leading: Image.asset('assets/icons/order.png'),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Order Id: " + "${data['oid']}"),
                            Text(
                              "${data['cname']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                        subtitle: Text("${data['date']}"),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "₹ ${data['total']}",
                              style: TextStyle(
                                  color: AppColors.mainPurple,
                                  fontSize: Dimensions.h18),
                            ),
                            Text(
                              "${data['orderStatus']}",
                              style: TextStyle(
                                  fontSize: Dimensions.h18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
        ));
  }
}
