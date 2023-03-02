import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kahumbo_admin/Constants/app_colors.dart';
import 'package:kahumbo_admin/Screens/category.dart';
import 'package:kahumbo_admin/Screens/customer_screen.dart';
import 'package:kahumbo_admin/Screens/feedback.dart';
import 'package:kahumbo_admin/Screens/login_screen.dart';
import 'package:kahumbo_admin/Screens/order_screen.dart';
import 'package:kahumbo_admin/Screens/pop_product_admin.dart';

import '../Helper/helper_function.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          "assets/images/Group.svg",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: ()async{
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title:  Row(
                      children: const [
                        Icon(Icons.logout_outlined,size: 20,color: Colors.red,),
                        Text(" Logout",style: TextStyle(color: Colors.red),),
                      ],
                    ),
                    content: const Text(
                        "Are you sure for Logout ?"),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.done,
                          color: Colors.green,
                          size: 30,
                        ),
                        onPressed:() async{
                              FirebaseAuth.instance
                              .signOut()
                              .whenComplete(() async {
                                  await HelperFunction.saveLogingData(false);
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamedAndRemoveUntil(context,
                                LoginPage.routeName,(route) => false);
                           });
                          },
                      ),
                    ],
                  );
                });
            
            }, icon: const Icon(Icons.logout)),
          )
        ],
        backgroundColor: AppColors.mainPurple,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [  

             SizedBox(height: size.height*0.001,),

             StreamBuilder(
              stream: FirebaseFirestore.instance.collection("customer").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              //customer
              return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(CustomerScreen.routeName);
              },
              child: Padding(
                    padding: const EdgeInsets.only(top:20.0,right: 20.0,left: 20.0),
                    child: Column(
                      children: [
                        Container(
                          height: size.height*0.1,
                          width: size.width,
                          decoration: BoxDecoration(
                            color:  const Color(0xFFECE6E9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color:AppColors.mainPurple),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.account_box,
                                            color: AppColors.mainPurple,
                                            size: 40,
                                          ),
                                          SizedBox(
                                            width: size.width*0.025,
                                          ),
                                        const Text( 
                                            "Customer",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: size.height*0.1,
                                  width: size.width*0.1,
                                  decoration:const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${snapshot.data!.docs.length}",
                                    style: const TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
            );
             }),

            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("category").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              //category
              return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(CategoryAdmin.routeName);
              },
              child: Padding(
                    padding: const EdgeInsets.only(top:20.0,right: 20.0,left: 20.0),
                    child: Column(
                      children: [
                        Container(
                          height: size.height*0.1,
                          width: size.width,
                          decoration: BoxDecoration(
                            color:  const Color(0xFFECE6E9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color:AppColors.mainPurple),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.app_registration,
                                            color: AppColors.mainPurple,
                                            size: 40,
                                          ),
                                          SizedBox(
                                            width: size.width*0.025,
                                          ),
                                        const Text( 
                                            "Category",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: size.height*0.1,
                                  width: size.width*0.1,
                                  decoration:const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${snapshot.data!.docs.length}",
                                    style: const TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
             }),

            SizedBox(height: size.height*0.001,),

             StreamBuilder(
              stream: FirebaseFirestore.instance.collection("order").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              // order
              return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(MyOrderPage.routeName);
              },
              child: Padding(
                    padding: const EdgeInsets.only(top:20.0,right: 20.0,left: 20.0),
                    child: Column(
                      children: [
                        Container(
                          height: size.height*0.1,
                          width: size.width,
                          decoration: BoxDecoration(
                            color:  const Color(0xFFECE6E9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color:AppColors.mainPurple),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.assignment_rounded,
                                            color: AppColors.mainPurple,
                                            size: 40,
                                          ),
                                          SizedBox(
                                            width: size.width*0.025,
                                          ),
                                        const Text( 
                                            "Orders",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: size.height*0.1,
                                  width: size.width*0.1,
                                  decoration:const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${snapshot.data!.docs.length}",
                                    style: const TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
             }),

             SizedBox(height: size.height*0.001,),

             StreamBuilder(
              stream: FirebaseFirestore.instance.collection("popular").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              // Popular Products
              return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(PopAdmin.routeName);
              },
              child: Padding(
                    padding: const EdgeInsets.only(top:20.0,right: 20.0,left: 20.0),
                    child: Column(
                      children: [
                        Container(
                          height: size.height*0.1,
                          width: size.width,
                          decoration: BoxDecoration(
                            color:  const Color(0xFFECE6E9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color:AppColors.mainPurple),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.favorite,
                                            color: AppColors.mainPurple,
                                            size: 40,
                                          ),
                                          SizedBox(
                                            width: size.width*0.025,
                                          ),
                                        const Text( 
                                            "Popular Products",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: size.height*0.1,
                                  width: size.width*0.1,
                                  decoration:const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${snapshot.data!.docs.length}",
                                    style: const TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
             }),

              SizedBox(height: size.height*0.001,),

             StreamBuilder(
              stream: FirebaseFirestore.instance.collection("feedback").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              // Feedback
              return GestureDetector(
              onTap: () {
                  Navigator.of(context).pushNamed(FeedbackAdmin.routeName);
              },
              child: Padding(
                    padding: const EdgeInsets.only(top:20.0,right: 20.0,left: 20.0),
                    child: Column(
                      children: [
                        Container(
                          height: size.height*0.1,
                          width: size.width,
                          decoration: BoxDecoration(
                            color:  const Color(0xFFECE6E9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color:AppColors.mainPurple),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.feedback,
                                            color: AppColors.mainPurple,
                                            size: 40,
                                          ),
                                          SizedBox(
                                            width: size.width*0.025,
                                          ),
                                        const Text( 
                                            "Feedback",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: size.height*0.1,
                                  width: size.width*0.1,
                                  decoration:const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${snapshot.data!.docs.length}",
                                    style: const TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
             }),
          ],
        ),
      ),
    );
  }
}




