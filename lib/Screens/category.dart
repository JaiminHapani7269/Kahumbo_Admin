import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kahumbo_admin/Constants/app_colors.dart';
import 'package:kahumbo_admin/Screens/product_screen.dart';
import 'dart:math';
import '../Constants/dimentions.dart';

class CategoryAdmin extends StatefulWidget {
  const CategoryAdmin({Key? key}) : super(key: key);

  static const String routeName = '/category_screen';

  @override
  State<CategoryAdmin> createState() => _CategoryAdminState();
}

class _CategoryAdminState extends State<CategoryAdmin> {
  final TextEditingController _editCategory = TextEditingController();
  final TextEditingController _createCategory = TextEditingController();
  final TextEditingController _iconConntroller = TextEditingController();
  final TextEditingController _editiconConntroller = TextEditingController();
  final TextEditingController _newPnameConntroller = TextEditingController();
  final TextEditingController _newPriceConntroller = TextEditingController();

  final FocusNode _createCategoryFocus = FocusNode();
  final FocusNode _iconFocus = FocusNode();
  final FocusNode _editiconFocus = FocusNode();
  final FocusNode _newPnameFocus = FocusNode();
  final FocusNode _newPriceFocus = FocusNode();

  final _key = GlobalKey<FormState>();
  var random = Random();
  int cid = 0;

  clearTextBox() {
    _createCategory.text = '';
    _editCategory.text = '';
    _iconConntroller.text = '';
    _editiconConntroller.text = '';
    _newPnameConntroller.text = '';
    _newPriceConntroller.text = '';
  }

  @override
  void dispose() {
    super.dispose();
    _createCategory.dispose();
    _editCategory.dispose();
    _iconConntroller.dispose();
  }

  String id = '';
  String colletion = '';
  @override
  Widget build(BuildContext context) {
    String rPID = 'RodUcT${random.nextInt(900000) + 100000}';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        centerTitle: true,
        backgroundColor: AppColors.mainPurple,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: IconButton(
                  onPressed: () async {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Row(
                              children: const [
                                Icon(
                                  Icons.add_rounded,
                                  size: 20,
                                  color: Colors.green,
                                ),
                                Text(
                                  " Create Category ",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                            content: SizedBox(
                              height: Dimensions.h200,
                              child: Form(
                                key: _key,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      focusNode: _createCategoryFocus,
                                      textInputAction: TextInputAction.next,
                                      autofocus: false,
                                      validator: (value) {
                                        if (_createCategory.text.isEmpty) {
                                          return "Please Enter Category Name";
                                        }
                                        return null;
                                      },
                                      controller: _createCategory,
                                      decoration: const InputDecoration(
                                          hintText: "Enter Category Name"),
                                    ),
                                    TextFormField(
                                      controller: _iconConntroller,
                                      focusNode: _iconFocus,
                                      textInputAction: TextInputAction.done,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                          hintText: "Enter Icon Path"),
                                    ),
                                    TextFormField(
                                      focusNode: _newPnameFocus,
                                      textInputAction: TextInputAction.next,
                                      autofocus: false,
                                      validator: (value) {
                                        if (_newPnameConntroller.text.isEmpty) {
                                          return "Please Enter Product Name";
                                        }
                                        return null;
                                      },
                                      controller: _newPnameConntroller,
                                      decoration: const InputDecoration(
                                          hintText: "Enter Product Name"),
                                    ),
                                    TextFormField(
                                      focusNode: _newPriceFocus,
                                      textInputAction: TextInputAction.next,
                                      autofocus: false,
                                      validator: (value) {
                                        if (_newPriceConntroller.text.isEmpty) {
                                          return "Please Enter Price";
                                        }
                                        return null;
                                      },
                                      controller: _newPriceConntroller,
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
                                        .doc()
                                        .set({
                                      'cid': cid,
                                      'cname': _createCategory.text,
                                      'icon': _iconConntroller.text,
                                    }).whenComplete(() {
                                      FirebaseFirestore.instance
                                          .collection("category")
                                          .doc(id)
                                          .collection(colletion)
                                          .doc(rPID)
                                          .set({
                                        'cid': cid - 1,
                                        'pid': rPID,
                                        'pname': _newPnameConntroller.text,
                                        'price': int.parse(
                                            _newPriceConntroller.text),
                                      }).whenComplete(() {
                                        Navigator.of(context).pop();
                                        clearTextBox();
                                        Fluttertoast.showToast(
                                            msg: "Category Added");
                                      });
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
                var data = snapshot.data!.docs[index];
                id = data.id;
                colletion = data['cname'];
                cid = snapshot.data!.docs.length + 1;
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CategoryProductScreen(
                            id: snapshot.data!.docs[index].id,
                            cid: snapshot.data!.docs[index]['cid'],
                            collection: snapshot.data!.docs[index]['cname'])));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFECE6E9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          snapshot.data!.docs[index]['icon'],
                          height: Dimensions.h40,
                          fit: BoxFit.cover,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(snapshot.data!.docs[index]['cname']),
                              ],
                            ),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        _editCategory.text =
                                            snapshot.data!.docs[index]['cname'];
                                        _editiconConntroller.text =
                                            snapshot.data!.docs[index]['icon'];

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
                                                      " Edit Category Name ",
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ),
                                                  ],
                                                ),
                                                content: SizedBox(
                                                  height: Dimensions.h100,
                                                  child: Form(
                                                      key: _key,
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            autofocus: false,
                                                            validator: (value) {
                                                              if (_editCategory
                                                                  .text
                                                                  .isEmpty) {
                                                                return "Please Enter Category Name";
                                                              }
                                                              return null;
                                                            },
                                                            controller:
                                                                _editCategory,
                                                            decoration:
                                                                const InputDecoration(
                                                                    hintText:
                                                                        "Enter Category Name"),
                                                          ),
                                                          TextFormField(
                                                            textInputAction:
                                                                TextInputAction
                                                                    .done,
                                                            autofocus: false,
                                                            controller:
                                                                _editiconConntroller,
                                                            focusNode:
                                                                _editiconFocus,
                                                            decoration:
                                                                const InputDecoration(
                                                                    hintText:
                                                                        "Enter Icon Path"),
                                                          ),
                                                        ],
                                                      )),
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
                                                      if (_key.currentState!
                                                          .validate()) {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "category")
                                                            .doc(snapshot.data!
                                                                .docs[index].id)
                                                            .update({
                                                          'cname': _editCategory
                                                              .text,
                                                          'icon':
                                                              _editiconConntroller
                                                                  .text,
                                                        }).whenComplete(() {
                                                          Navigator.of(context)
                                                              .pop();
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Category Updated Successfully !");
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
                                                      " Delete Category",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ],
                                                ),
                                                content: Text(
                                                    "Are you sure for Delete Category     " +
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['cname'] +
                                                        " ?"),
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
                                                      setState(() {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "category")
                                                            .doc(snapshot.data!
                                                                .docs[index].id)
                                                            .delete()
                                                            .then((value) =>
                                                                setState(() {
                                                                  Navigator.pop(
                                                                      context);
                                                                  Fluttertoast
                                                                      .showToast(
                                                                          msg:
                                                                              "Category Delete Sucessfully!");
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
                  ),
                );
              });
        },
      )),
    );
  }
}

class Category extends StatelessWidget {
  final String icon;
  final String cname;
  final Function()? onTap;
  const Category({
    Key? key,
    required this.icon,
    required this.cname,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
        child: Container(
          width: Dimensions.w80,
          height: Dimensions.h80,
          padding: EdgeInsets.only(
              left: Dimensions.w5,
              right: Dimensions.w5,
              bottom: Dimensions.h10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFECE6E9),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.r24),
              bottomLeft: Radius.circular(Dimensions.r24),
              topLeft: Radius.circular(Dimensions.r8),
              bottomRight: Radius.circular(Dimensions.r8),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                height: Dimensions.h40,
              ),
              Text(
                cname,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.mainPurple),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
