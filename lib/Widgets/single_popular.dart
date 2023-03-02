// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_typing_uninitialized_variables, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Constants/app_colors.dart';
import '../Constants/dimentions.dart';

class SinglePopularTile extends StatefulWidget {
  final String id;
  final String pid;
  final String pname;
  final String image;
  var price;
  bool isInFavorite = false;
  bool isInCart = false;

  SinglePopularTile({
    Key? key,
    required this.id,
    required this.pid,
    required this.pname,
    required this.image,
    required this.price,
  }) : super(key: key);

  @override
  State<SinglePopularTile> createState() => _SinglePopularTileState();
}

class _SinglePopularTileState extends State<SinglePopularTile> {

  final TextEditingController _editpop = TextEditingController();
  final TextEditingController _imageConntroller = TextEditingController();
  final TextEditingController _poprice = TextEditingController();
  final _key = GlobalKey<FormState>();

  clearTextBox(){
    _editpop.text = '';
    _imageConntroller.text = '';
    _poprice.text = '';
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.h5, horizontal: Dimensions.w5),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFECE6E9),
          borderRadius: BorderRadius.circular(Dimensions.r12),
        ),
        child: ListTile(
          leading: Container(
            height: Dimensions.h50,
            width: Dimensions.w50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.r8),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.image),
                )),
          ),
          title: Text(
            widget.pname,
            style: TextStyle(
                color: AppColors.mainPurple,
                fontSize: Dimensions.h18,
                fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
            "₹ ${widget.price}",
            style: TextStyle(color: Colors.black, fontSize: Dimensions.h15),
          ),
          trailing: Container(
            height: Dimensions.h24,
            width: Dimensions.w50 + 20,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: IntrinsicHeight(
                              child: Row(
                                children:[
                                   InkWell(
                                    onTap:  () async {

                                      _editpop.text = widget.pname;
                                      _imageConntroller.text = widget.image;
                                      _poprice.text = widget.price.toString();

                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Row(
                                                  children: const[
                                                     Icon(Icons.edit,size: 20,color: Colors.green,),
                                                     Text(" Edit Popular Product ",style: TextStyle(color: Colors.green),),
                                                  ],
                                                ),
                                                content: SizedBox(
                                                  height: 150,
                                                  child: Form(
                                                    key: _key,
                                                    child: Column(
                                                      children: [
                                                        TextFormField(
                                                          textInputAction: TextInputAction.next,
                                                          autofocus: false,
                                                          validator: (value) {
                                                            if(_editpop.text.isEmpty){
                                                              return "Please Enter Popular Product Name";
                                                            }
                                                            return null;
                                                          },
                                                          controller: _editpop,
                                                          decoration: const InputDecoration(
                                                              hintText: "Enter Popular Product Name"
                                                          ),
                                                        ),
                                                        TextFormField(
                                                          textInputAction: TextInputAction.next,
                                                          keyboardType:TextInputType.number,
                                                          autofocus: false,
                                                          validator: (value) {
                                                            if(_poprice.text.isEmpty){
                                                              return "Please Enter Popular Product Price";
                                                            }
                                                            return null;
                                                          },
                                                          controller: _poprice,
                                                          decoration: const InputDecoration(
                                                              hintText: "Enter Popular Product Price",

                                                          ),
                                                        ),
                                                        TextFormField(
                                                          textInputAction: TextInputAction.done,
                                                          autofocus: false,
                                                          controller: _imageConntroller,
                                                          decoration: const InputDecoration(
                                                              hintText: "Enter Image Path"
                                                          ),
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
                                                    onPressed:() async {
                                                      if(_key.currentState!.validate()){
                                                        FirebaseFirestore.instance
                                                        .collection("popular")
                                                        .doc(widget.id)
                                                        .update({
                                                          'pname':_editpop.text,
                                                          'price':int.parse(_poprice.text),
                                                          'image':_imageConntroller.text,
                                                        }).whenComplete(() {
                                                          Navigator.of(context).pop();
                                                          Fluttertoast.showToast(msg: "Popular Product Update..");
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                    child:const Icon(Icons.edit,color: Colors.green,)
                                  ),
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
                                                title:  Row(
                                                  children:const [
                                                    Icon(Icons.delete,color: Colors.red,size: 20,),
                                                    Text(" Delete Popular Product",style: TextStyle(color: Colors.red),),
                                                  ],
                                                ),
                                                content: Text(
                                                    "Are you sure for Delete Popular Product " + productname + " ?"),
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
                                                        setState(() {
                                                            FirebaseFirestore.instance
                                                                .collection("popular")
                                                                .doc(widget.id)
                                                                .delete()
                                                                .then((value) => setState(() {
                                                              Fluttertoast.showToast(msg: "Popular Product Delete Sucessfully!");
                                                              Navigator.of(context).pop();
                                                              clearTextBox();
                                                            }));
                                                        });
                                                      },
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                    child: const Icon(Icons.delete,color: Colors.red,)
                                  ),
                                ],
                              ),
                            ),
          ),
        ),
      ),
    );
  }
}
