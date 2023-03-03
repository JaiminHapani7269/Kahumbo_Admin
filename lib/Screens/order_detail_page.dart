// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_unnecessary_containers
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kahumbo_admin/Screens/order_screen.dart';
import '../Constants/app_colors.dart';
import '../Constants/dimentions.dart';
import '../Model/user_model.dart';

class OrderDetailsPage extends StatefulWidget {
  OrderDetailsPage({
    Key? key,
    required this.oid,
    required this.name,
    required this.phone,
    required this.product,
    required this.date,
    required this.hno,
    required this.address,
    required this.area,
    required this.city,
    required this.state,
    required this.pincode,
    required this.total,
    required this.orderstatus,
  }) : super(key: key);
  final String oid;
  final String name;
  final String phone;
  final String product;
  final String date;
  final String hno;
  final String address;
  final String area;
  final String city;
  final String state;
  final String pincode;
  var total;
  final String orderstatus;

  static const String routeName = '/order_detail_screen';

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController feedbackController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String c_name = '';
  final date = DateTime.now();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("customer")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        c_name = loggedInUser.c_name!;
      });
    });
  }

  String _dropDownValue = '-- Order Status --';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainPurple,
        centerTitle: true,
        title: const Text(
          "Order Details",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(Dimensions.w20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Order No.: ",
                              style: TextStyle(
                                  color: AppColors.mainPurple,
                                  fontSize: Dimensions.h20),
                            ),
                            Text(
                              widget.oid,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: Dimensions.h20),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Order Date : ",
                              style: TextStyle(
                                  color: AppColors.mainPurple,
                                  fontSize: Dimensions.h15),
                            ),
                            Text(
                              widget.date,
                              style: TextStyle(fontSize: Dimensions.h15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/icons/order.png',
                        width: 70,
                        height: 70,
                        fit: BoxFit.contain,
                      )),
                ],
              ),
              SizedBox(height: Dimensions.h10),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.04,
                      decoration: const BoxDecoration(color: Color(0xFFECE6E9)),
                      child: const Center(
                        child: Text(
                          'Customer Information',
                          style: TextStyle(
                              color: AppColors.mainPurple, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.h10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Name : ",
                          style: TextStyle(
                            fontSize: Dimensions.h18,
                          ),
                        ),
                        Text(
                          widget.name,
                          style: TextStyle(
                              color: Colors.green, fontSize: Dimensions.h18),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.h5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Mobile No : ",
                          style: TextStyle(
                            fontSize: Dimensions.h18,
                          ),
                        ),
                        Text(
                          widget.phone,
                          style: TextStyle(
                              color: Colors.green, fontSize: Dimensions.h18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h10),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.04,
                      decoration: const BoxDecoration(color: Color(0xFFECE6E9)),
                      child: const Center(
                        child: Text(
                          'Product Information',
                          style: TextStyle(
                              color: AppColors.mainPurple, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.h10),
                    Text(
                      widget.product,
                      style: TextStyle(fontSize: Dimensions.h20),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h20),
              SizedBox(
                // height: Dimensions.h120 + 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.04,
                      decoration: const BoxDecoration(color: Color(0xFFECE6E9)),
                      child: const Center(
                        child: Text(
                          'Delivery Information',
                          style: TextStyle(
                              color: AppColors.mainPurple, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.h10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.hno},${widget.address},",
                          style: TextStyle(fontSize: Dimensions.h18),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.area},",
                          style: TextStyle(fontSize: Dimensions.h18),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " ${widget.city}, ${widget.pincode}",
                          style: TextStyle(fontSize: Dimensions.h18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h20),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Current Order Status : ",
                      style: TextStyle(
                          fontSize: Dimensions.h18,
                          color: AppColors.mainPurple),
                    ),
                    Text(
                      widget.orderstatus,
                      style: TextStyle(
                          fontSize: Dimensions.h18, color: Colors.green),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h20),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Update Status : ",
                      style: TextStyle(
                          fontSize: Dimensions.h18,
                          color: AppColors.mainPurple),
                    ),
                    SizedBox(
                      width: Dimensions.w180,
                      child: DropdownButton<String>(
                        hint: Text(
                          _dropDownValue,
                          style: const TextStyle(color: AppColors.mainPurple),
                        ),
                        isExpanded: true,
                        iconSize: 40.0,
                        iconEnabledColor: AppColors.mainPurple,
                        style: const TextStyle(color: Colors.green),
                        items:
                            ['Placed', 'Prepared', 'Shipped', 'Delivered'].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              _dropDownValue = val.toString();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainPurple,
                    ),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("order")
                          .doc(widget.oid)
                          .update({'orderStatus': _dropDownValue}).whenComplete(
                              () => Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => MyOrderPage(),
                                  )));
                    },
                    child: Text('Update')),
              ),
            ],
          ),
        )),
      ),
      bottomNavigationBar: Container(
        height: Dimensions.h80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.r24),
            topRight: Radius.circular(Dimensions.r24),
          ),
          color: AppColors.mainPurple.withOpacity(0.2),
        ),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.h15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Grand Total:",
                style: TextStyle(
                    color: AppColors.mainPurple, fontSize: Dimensions.h24),
              ),
              Text(
                "₹ ${widget.total}",
                style: TextStyle(
                    color: AppColors.mainPurple, fontSize: Dimensions.h24),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    feedbackController.dispose();
  }
}
