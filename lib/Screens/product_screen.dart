import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kahumbo_admin/Constants/dimentions.dart';
import 'dart:math';

import '../Constants/app_colors.dart';
import '../Widgets/single_product.dart';

class CategoryProductScreen extends StatefulWidget {
  final String id;
  final String collection;
  final int cid;
  const CategoryProductScreen({
    Key? key,
    required this.id,
    required this.cid,
    required this.collection,
  }) : super(key: key);

  static const String routeName = '/product_screen';

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _createProductName = TextEditingController();
  final TextEditingController _createProductPrice = TextEditingController();

  final _key = GlobalKey<FormState>();
  var random = Random();

  String productid = '';

  clearTextBox() {
    _createProductName.text = '';
    _createProductPrice.text = '';
  }

  void dispose() {
    super.dispose();
    _createProductName.dispose();
    _createProductPrice.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String rPID = 'RodUcT${random.nextInt(900000) + 100000}';
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.mainPurple,
        centerTitle: true,
        title: Text("${widget.collection}"),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: IconButton(
                  onPressed: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Row(
                              children: const [
                                Icon(
                                  Icons.add,
                                  size: 20,
                                  color: Colors.green,
                                ),
                                Text(
                                  " Create Product ",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                            content: SizedBox(
                              height: 100,
                              child: Form(
                                key: _key,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _createProductName,
                                      textInputAction: TextInputAction.next,
                                      validator: ((value) {
                                        if (_createProductName.text.isEmpty) {
                                          return "please enter product name";
                                        }
                                        return null;
                                      }),
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                          hintText: "Enter Product Name"),
                                    ),
                                    TextFormField(
                                      controller: _createProductPrice,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      autofocus: false,
                                      validator: ((value) {
                                        if (_createProductPrice.text.isEmpty) {
                                          return "please enter price ";
                                        }
                                        return null;
                                      }),
                                      decoration: const InputDecoration(
                                          hintText: "Enter Product Price"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                                onPressed: () async {
                                  if (_key.currentState!.validate()) {
                                    await FirebaseFirestore.instance
                                        .collection("category")
                                        .doc(widget.id)
                                        .collection("${widget.collection}")
                                        .doc(rPID)
                                        .set({
                                      'cid': widget.cid,
                                      'pid': rPID,
                                      'pname': _createProductName.text,
                                      'price':
                                          int.parse(_createProductPrice.text),
                                    }).whenComplete(() {
                                      Navigator.of(context).pop();
                                      Fluttertoast.showToast(
                                          msg: "Product Added");
                                      clearTextBox();
                                    });
                                  }
                                },
                              ),
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.add,
                    color: AppColors.mainPurple,
                  )),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.w15),
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("category")
              .doc(widget.id)
              .collection(widget.collection)
              .get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainPurple,
                ),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];
                  productid = "pRoDUct${snapshot.data!.docs.length + 1}";
                  return SingleProductTile(
                    id: data.id,
                    pid: data['pid'],
                    pname: data['pname'],
                    price: data['price'],
                    cid: widget.id,
                    collection: widget.collection,
                  );
                });
          },
        ),
      ),
    );
  }
}
