import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kahumbo_admin/Constants/app_colors.dart';
import 'package:kahumbo_admin/Constants/dimentions.dart';
import 'package:kahumbo_admin/Screens/demodb.dart';
import 'package:kahumbo_admin/Screens/home_screen.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = '/login_screen';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                     Text(
                      "Welcome   ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "ADMIN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.mainPurple,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Image.asset("assets/images/login.png"),
                const SizedBox(height: 20),

                //Email
                // TextFormField(
                //   controller: emailController,
                //   autofocus: false,
                //   textInputAction: TextInputAction.next,
                //   keyboardType: TextInputType.emailAddress,
                //   decoration: InputDecoration(
                //     labelText: 'E-mail',
                //   ),
                //   validator: (value) {
                //     if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                //         .hasMatch(value!)) {
                //       return ("Please Enter a valid email");
                //     }
                //     return null;
                //   },
                //   onSaved: (newValue) => emailController.text = newValue!,
                // ),


                //Password
                TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  autofocus: false,
                  obscureText: true,
                  cursorColor: AppColors.mainPurple,
                  decoration:const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: AppColors.mainPurple),
                    focusColor: AppColors.mainPurple,
                    prefixIcon: Icon(Icons.lock,color: AppColors.mainPurple,),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.mainPurple)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.mainPurple)),
                  ),
                  validator: (value) {
                    if (passwordController.text.isEmpty) {
                      return "Please enter your password";
                    }
                  },
                  onSaved: (newValue) => passwordController.text = newValue!,
                ),
                const SizedBox(height: 40),

                //loginin button
                SizedBox(
                  width: double.infinity,
                  height: Dimensions.h50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainPurple,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () {
                      signIn("admin123@gmail.com", passwordController.text);
                    },
                  ),
                ),
                SizedBox(height:Dimensions.h200 - 40,),
                Image.asset("assets/images/logo.jpg",height: 50,)
              ],
            ),
          ),
        ),
        
      ),
    );
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  // Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const HomeScreen())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        // Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}