import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../Constants/app_colors.dart';
import '../Constants/dimentions.dart';
import '../Widgets/single_popular.dart';

class PopAdmin extends StatefulWidget {
  const PopAdmin({super.key});

  static const String routeName = '/pop_screen';

  @override
  State<PopAdmin> createState() => _PopAdminState();
}

class _PopAdminState extends State<PopAdmin> {

  final TextEditingController _editpop = TextEditingController();
  final TextEditingController _createpop = TextEditingController();
  final TextEditingController _imageConntroller = TextEditingController();
  final TextEditingController _poprice = TextEditingController();
  final _key = GlobalKey<FormState>();

  String pid = '' ;

  clearTextBox(){
    _editpop.text = '';
    _createpop.text = '';
    _imageConntroller.text = '';
    _poprice.text = '';
  }

  @override
  void dispose() {
    super.dispose();
    _createpop.dispose();
    _editpop.dispose();
    _imageConntroller.dispose();
    _poprice.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Products"),
        centerTitle: true,
        backgroundColor: AppColors.mainPurple,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
              ),
              child: IconButton(onPressed: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          children: const[
                             Icon(Icons.add_rounded,size: 20,color: Colors.green,),
                             Text(" Create Popular Product ",style: TextStyle(color: Colors.green),),
                          ],
                        ),
                        content: SizedBox(
                          height: Dimensions.h120 + 25,
                          child: Form(
                            key: _key,
                            child: Column(
                              children: [
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  autofocus: false,
                                  validator: (value) {
                                    if(_createpop.text.isEmpty){
                                      return "Please Enter Popular Product Name";
                                    }
                                    return null;
                                  },
                                  controller: _createpop,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Popular Product Name"
                                  ),
                                ),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType:TextInputType.number ,
                                  autofocus: false,
                                  validator: (value) {
                                    if(_poprice.text.isEmpty){
                                      return "Please Enter Popular Product Price";
                                    }
                                    return null;
                                  },
                                  controller: _poprice,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Popular Product Price"
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
                            onPressed: () async {
                              if(_key.currentState!.validate()){
                                await FirebaseFirestore.instance
                                .collection("popular")
                                .doc(pid)
                                .set({
                                  'pid':pid,
                                  'pname':_createpop.text,
                                  'image':_imageConntroller.text,
                                  'price':int.parse(_poprice.text),
                                }).whenComplete(() {
                                  Navigator.of(context).pop();
                                  clearTextBox();
                                  Fluttertoast.showToast(msg: "Popular Product Added");
                                });
                              }
                            },
                          ),
                        ],
                      );
                    });
              }, icon:const Icon(Icons.add,color: AppColors.mainPurple,))
              ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Dimensions.h10),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("popular")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: AppColors.mainPurple,
                      ));
                    }
                    return Padding(
                      padding: EdgeInsets.all(
                          Dimensions.w15),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index];
                            pid = "pOPulaR${snapshot.data!.docs.length +1}";
                            return SinglePopularTile(
                                id:snapshot.data!.docs[index].id,
                                pid: data['pid'],
                                pname: data['pname'],
                                image: data['image'],
                                price: data['price']);
                          }),
                    );
                  })
          ],
        ),
      ),
    );
  }
}