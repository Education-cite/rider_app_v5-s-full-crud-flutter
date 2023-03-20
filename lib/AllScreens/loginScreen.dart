import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app_v3/AllScreens/dashboard.dart';
import 'package:rider_app_v3/AllScreens/mainsreen.dart';
import 'package:rider_app_v3/AllScreens/registrationScreen.dart';
import 'package:rider_app_v3/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const String idScreen = "login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool _isNotValided = false;
  late SharedPreferences prefs;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async{
    prefs = await SharedPreferences.getInstance();
  }

  final String login = 'https://jsonplaceholder.typicode.com';
  void _login() async {
    if (emailTextEditingController.text.isNotEmpty &&
        passwordTextEditingController.text.isNotEmpty) {
      var reqBody = {
        "userName": emailTextEditingController.text,
        "pass": passwordTextEditingController.text,
      };

      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Dashboard(token: myToken)));
      } else {
        print('Something went wrong');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 35.0,
              ),
              Image(
                image: AssetImage("images/logo.png"),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 1.0,
              ),
              Text(
                "Login as a Rider",
                style: TextStyle(fontSize: 25, fontFamily: "bolt-semibold"),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        // hintText: "Email",
                        hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        // hintText: "Email",
                        hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.yellow),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                // side: BorderSide(color: Colors.red)
                              ))),
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "bolt-semibold",
                                color: Colors.white),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (!emailTextEditingController.text.contains("@")) {
                          displayToastMessage("Invalid email. ", context);
                        } else if (passwordTextEditingController.text.length <
                            6) {
                          displayToastMessage("Invalid password. ", context);
                        } else {
                          loginAndAuthenticateUser(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RegistrationScreen.idScreen, (route) => false);
                    // print("Registered Button Clicked");
                  },
                  child: Text("Do not have a Account? Register Here"))
            ],
          ),
        ),
      ),
    );
  }



  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  loginAndAuthenticateUser(BuildContext context) async {
    // print("-----------------------");

    final User? user = (await _firebaseAuth
        .signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text)
        .catchError((errMsg) {
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (user != null) {
      print("-----------------------");
      usersRef.child(user.uid).once().then((value) => (DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.idScreen, (route) => false);
          displayToastMessage("Logged-in", context);
        } else {
          _firebaseAuth.signOut();
          displayToastMessage("User Not Exists. Please Sign-up.", context);
        }
      });
    } else {
      displayToastMessage("Something is wrong!!", context);
    }
  }
}




//
// class LoginScreen extends StatelessWidget {
//   LoginScreen({Key? key}) : super(key: key);
//   static const String idScreen = "login";
//   TextEditingController emailTextEditingController = TextEditingController();
//   TextEditingController passwordTextEditingController = TextEditingController();
//   bool _isNotValided = false;
//   late SharedPreferences prefs;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     initSharedPref();
//   }
//
//   void initSharedPref() async{
//     prefs = await SharedPreferences.getInstance();
//   }
//
//   final String login = 'https://jsonplaceholder.typicode.com';
//   void _login() async {
//     if (emailTextEditingController.text.isNotEmpty &&
//         passwordTextEditingController.text.isNotEmpty) {
//       var reqBody = {
//         "userName": emailTextEditingController.text,
//         "pass": passwordTextEditingController.text,
//       };
//
//       var response = await http.post(Uri.parse(login),
//           headers: {"Content-Type": "application/json"},
//           body: jsonEncode(reqBody));
//
//       var jsonResponse = jsonDecode(response.body);
//       if (jsonResponse['status']) {
//         var myToken = jsonResponse['token'];
//         prefs.setString('token', myToken);
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => Dashboard(token: myToken)));
//       } else {
//         print('Something went wrong');
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 35.0,
//               ),
//               Image(
//                 image: AssetImage("images/logo.png"),
//                 width: 390.0,
//                 height: 250.0,
//                 alignment: Alignment.center,
//               ),
//               SizedBox(
//                 height: 1.0,
//               ),
//               Text(
//                 "Login as a Rider",
//                 style: TextStyle(fontSize: 25, fontFamily: "bolt-semibold"),
//                 textAlign: TextAlign.center,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 1.0,
//                     ),
//                     TextField(
//                       controller: emailTextEditingController,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                         labelText: "Email",
//                         labelStyle: TextStyle(
//                           fontSize: 14.0,
//                         ),
//                         // hintText: "Email",
//                         hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
//                       ),
//                       style: TextStyle(fontSize: 14.0),
//                     ),
//                     SizedBox(
//                       height: 1.0,
//                     ),
//                     TextField(
//                       controller: passwordTextEditingController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         labelText: "Password",
//                         labelStyle: TextStyle(
//                           fontSize: 14.0,
//                         ),
//                         // hintText: "Email",
//                         hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
//                       ),
//                       style: TextStyle(fontSize: 14.0),
//                     ),
//                     SizedBox(
//                       height: 10.0,
//                     ),
//                     SizedBox(
//                       height: 10.0,
//                     ),
//                     TextButton(
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.yellow),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(24.0),
//                             // side: BorderSide(color: Colors.red)
//                           ))),
//                       child: Container(
//                         height: 50.0,
//                         child: Center(
//                           child: Text(
//                             "Login",
//                             style: TextStyle(
//                                 fontSize: 18.0,
//                                 fontFamily: "bolt-semibold",
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                       onPressed: () {
//                         if (!emailTextEditingController.text.contains("@")) {
//                           displayToastMessage("Invalid email. ", context);
//                         } else if (passwordTextEditingController.text.length <
//                             6) {
//                           displayToastMessage("Invalid password. ", context);
//                         } else {
//                           loginAndAuthenticateUser(context);
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               TextButton(
//                   onPressed: () {
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, RegistrationScreen.idScreen, (route) => false);
//                     // print("Registered Button Clicked");
//                   },
//                   child: Text("Do not have a Account? Register Here"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   loginAndAuthenticateUser(BuildContext context) async {
//     // print("-----------------------");
//
//     final User? user = (await _firebaseAuth
//             .signInWithEmailAndPassword(
//                 email: emailTextEditingController.text,
//                 password: passwordTextEditingController.text)
//             .catchError((errMsg) {
//       displayToastMessage("Error: " + errMsg.toString(), context);
//     }))
//         .user;
//
//     if (user != null) {
//       print("-----------------------");
//       usersRef.child(user.uid).once().then((value) => (DataSnapshot snap) {
//             if (snap.value != null) {
//               Navigator.pushNamedAndRemoveUntil(
//                   context, MainScreen.idScreen, (route) => false);
//               displayToastMessage("Logged-in", context);
//             } else {
//               _firebaseAuth.signOut();
//               displayToastMessage("User Not Exists. Please Sign-up.", context);
//             }
//           });
//     } else {
//       displayToastMessage("Something is wrong!!", context);
//     }
//   }
// }
