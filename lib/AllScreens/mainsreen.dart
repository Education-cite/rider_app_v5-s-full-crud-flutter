import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rider_app_v3/apiCall/pages/home.dart';
import 'package:rider_app_v3/crudFirebase/page/listpage.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);
//   static const String idScreen = "mainScreen";
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Main Screen"),
//       ),
//     );
//   }
// }
class MainScreen extends StatelessWidget {
  static const String idScreen = "mainScreen";
  TextEditingController taskTextEditingController = TextEditingController();

  _addTask() {
    FirebaseFirestore.instance
        .collection("todos")
        .add({"title": taskTextEditingController.text});
    taskTextEditingController.text = "";
  }
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  getMap(map) {
    if (map != null) {
      return map["title"];
    }
    return "";
  }

  _buildList(QuerySnapshot qs) {
    return ListView.builder(
        itemCount: qs.docs.length,
        itemBuilder: (context, index) {
          // final doc = qs.docs[index];
          // final map = doc!.data();
          final DocumentSnapshot map = qs.docs[index];

          return ListTile(
            // title: Text(getMap(map)),
            title: Text(map["title"]),

          );
        });
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: taskTextEditingController,
                  decoration: InputDecoration(
                    hintText: "Enter Task Name",
                    hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
                  ),
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              // Spacer(),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.yellow),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17.0),
                      // side: BorderSide(color: Colors.red)
                    ))),
                child: Container(
                  height: 30.0,
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
                  _addTask();
                },
              ),

              TextButton(
                  onPressed: () {
                    // Navigator.pushAndRemoveUntil<dynamic>(
                    //   context,
                    //   MaterialPageRoute<dynamic>(
                    //     builder: (BuildContext context) => Home(),
                    //   ),
                    //   (route) =>
                    //       false, //if you want to disable back feature set to false
                    // );
                    Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);

                  },
                  child: const Text('Task CRUD')),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("todos").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return LinearProgressIndicator();
              } else {
                return Expanded(
                  child: _buildList(snapshot.data!),
                );
              }
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Screen"),
      ),
      body: _buildBody(context),
    );
  }
}
