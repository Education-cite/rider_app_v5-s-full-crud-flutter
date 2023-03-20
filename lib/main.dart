import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rider_app_v3/AllScreens/dashboard.dart';
import 'package:rider_app_v3/AllScreens/loginScreen.dart';
import 'package:rider_app_v3/AllScreens/mainsreen.dart';
import 'package:rider_app_v3/AllScreens/registrationScreen.dart';
import 'package:rider_app_v3/apiCall/modles/user_model.dart';
import 'package:rider_app_v3/apiCall/pages/create.dart';
import 'package:rider_app_v3/apiCall/pages/detail.dart';
import 'package:rider_app_v3/apiCall/pages/home.dart';
import 'package:rider_app_v3/crudFirebase/page/listpage.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(token: prefs.getString('token'),));
}





DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");
// DatabaseReference taskRef = FirebaseDatabase.instance.ref().child("todos");

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  final token;
  const MyApp({
    @required this.token,
    Key? key,
  }): super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Taxi Ride App',
      theme: ThemeData(
          fontFamily: "Signatra",
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity
      ),

      initialRoute: "/home",
      //  initialRoute: (token != null && JwtDecoder.isExpired(token) == false )?"/dash":"/login",


      // home:  const RegistrationScreen(),
      routes: {
        RegistrationScreen.idScreen: (context) => RegistrationScreen(),
        "/login": (context) => LoginScreen(),
        MainScreen.idScreen: (context) => MainScreen(),
        ListPage.idScreen: (context) => ListPage(),
        "/home": (context) => Home(),
        "/dash": (context) => Dashboard(token: token),
        "/create": (context) => FormApp(),


        // "/detail": (context) => Detail(userModel: ),



      },
      debugShowCheckedModeBanner: false,
    );
  }
}
