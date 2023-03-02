// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kahumbo_admin/Constants/dimentions.dart';
import '../Constants/app_colors.dart';
import 'dart:math';

class SingleProductTile extends StatefulWidget {
  final String id;
  final String pid;
  final String pname;
  final String cid;
  String collection;
  var price;
  bool isInFavorite = false;
  bool isInCart = false;

  SingleProductTile(
      {Key? key,
      required this.id,
      required this.pid,
      required this.pname,
      required this.price,
      required this.cid,
      required this.collection})
      : super(key: key);

  @override
  State<SingleProductTile> createState() => _SingleProductTileState();
}

class _SingleProductTileState extends State<SingleProductTile> {
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();
  final _key = GlobalKey<FormState>();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  var random = Random();
  @override
  Widget build(BuildContext context) {
    String rPID = 'RodUcT${random.nextInt(900000) + 100000}';
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.h5, horizontal: Dimensions.w5),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFECE6E9),
          borderRadius: BorderRadius.circular(Dimensions.r12),
        ),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pname,
                    style: TextStyle(
                        color: AppColors.mainPurple,
                        fontSize: Dimensions.h18,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "₹ ${widget.price}",
                    style: TextStyle(
                        color: Colors.black, fontSize: Dimensions.h15),
                  ),
                ],
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    InkWell(
                        onTap: () async {
                          _productName.text = widget.pname;
                          _productPrice.text = widget.price.toString();

                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Row(
                                    children: const [
                                      Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        " Edit Product ",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  content: SizedBox(
                                    height: 100,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          textInputAction: TextInputAction.next,
                                          autofocus: false,
                                          validator: (value) {
                                            if (_productName.text.isEmpty) {
                                              return "Please Enter Category Name";
                                            }
                                            return null;
                                          },
                                          controller: _productName,
                                          focusNode: _nameFocus,
                                          decoration: const InputDecoration(
                                              hintText: "Enter Category Name"),
                                        ),
                                        TextFormField(
                                          textInputAction: TextInputAction.done,
                                          autofocus: false,
                                          controller: _productPrice,
                                          focusNode: _priceFocus,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              hintText: "Enter Product Price"),
                                        ),
                                      ],
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
                                              .collection(widget.collection)
                                              .doc(widget.pid)
                                              .update({
                                            'cid': widget.cid,
                                            'pid': widget.pid,
                                            'pname': _productName.text,
                                            'price':
                                                int.parse(_productPrice.text),
                                          }).whenComplete(() {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Product Updated Successfully !");
                                            Navigator.of(context).pop();
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: const Icon(
                          Icons.edit,
                          color: Colors.green,
                        )),
                    const VerticalDivider(
                      color: AppColors.mainPurple,
                      thickness: 2,
                    ),
                    InkWell(
                        onTap: () async {
                          var productname = widget.pname;

                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Row(
                                    children: const [
                                      Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        " Delete Product",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  content: Text("Are you sure for Delete " +
                                      productname +
                                      " ?"),
                                  actions: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        dispose();
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
                                        setState(() {
                                          FirebaseFirestore.instance
                                              .collection("category")
                                              .doc(widget.cid)
                                              .collection(widget.collection)
                                              .doc(widget.pid)
                                              .delete()
                                              .then((value) => setState(() {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Product Delete Sucessfully!");
                                                    Navigator.of(context).pop();
                                                  }));
                                        });
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
