import 'package:flutter/material.dart';
import 'package:rider_app_v3/apiCall/modles/product.dart';
import 'package:rider_app_v3/apiCall/modles/user_model.dart';
import 'package:rider_app_v3/apiCall/modles/user_model_2.dart';
import 'package:rider_app_v3/apiCall/pages/edit.dart';
import 'package:rider_app_v3/apiCall/pages/editData.dart';
import 'package:rider_app_v3/apiCall/pages/home.dart';
import 'package:rider_app_v3/apiCall/service/apiService.dart';
import 'package:rider_app_v3/apiCall/service/productApiService.dart';

class Detail extends StatelessWidget {
  final UserModel? userModel;
  final Posts? posts;
  final Product? product;

  const Detail({Key? key, this.userModel, this.posts, this.product}) : super(key: key);


  Widget getProduct(context){
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 1.0),
            Text(
              "Id : " + product!.id.toString(),
              style: TextStyle(fontSize: 15, fontFamily: "bolt-semibold"),
              textAlign: TextAlign.left,
            ),
            SizedBox(width: 1.0), // give it width

            Text(
              product!.name.toString(),
              style: TextStyle(fontSize: 10, fontFamily: "bolt-semibold"),
              textAlign: TextAlign.left,
            ),
            SizedBox(width: 1.0), // give it width

            TextButton(
                onPressed: () async {
                  (await ProductApiService().deleteProduct(product!.id));
                  // print("Delete Call!");
                  Navigator.pushAndRemoveUntil<dynamic>(context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) =>Home(),
                    ),
                        (route) =>false,
                  );
                },
                child: Icon(Icons.delete)),
            TextButton(onPressed: () {

              Navigator.pushAndRemoveUntil<dynamic>(context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) =>Edit(product: product),
                ),
                    (route) =>false,
              );
              print("Update Call!");
            }, child: Icon(Icons.update)),
          ],
          // Text(_postsModel![index].body.toString()),
        ),
      ),
    );
  }



  Widget getPost(context){
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 1.0),
            Text(
              "Id : " + posts!.id.toString(),
              style: TextStyle(fontSize: 15, fontFamily: "bolt-semibold"),
              textAlign: TextAlign.left,
            ),
            SizedBox(width: 1.0), // give it width

            Text(
              posts!.body.toString(),
              style: TextStyle(fontSize: 10, fontFamily: "bolt-semibold"),
              textAlign: TextAlign.left,
            ),
            SizedBox(width: 1.0), // give it width

            TextButton(
                onPressed: () async {
                  (await ApiService().deletePosts(posts!.id));
                  // print("Delete Call!");
                },
                child: Icon(Icons.delete)),
            TextButton(onPressed: () {
              print("Update Call!");
            }, child: Icon(Icons.update)),
          ],
          // Text(_postsModel![index].body.toString()),
        ),
      ),
    );
  }



  Widget getUser(context){
    return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 35.0,
                ),
                Text(
                  "Login as a Rider",
                  style: TextStyle(fontSize: 25, fontFamily: "bolt-semibold"),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 35.0,
                ),
                Text(
                  "Login as a Rider",
                  style: TextStyle(fontSize: 25, fontFamily: "bolt-semibold"),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 35.0,
                ),
                Text(
                  "Login as a Rider",
                  style: TextStyle(fontSize: 25, fontFamily: "bolt-semibold"),
                  textAlign: TextAlign.center,
                ),
               ]
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // (userModel != null) ? userModel!.name : posts!.title.toString(),
          product!.name.toString(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.pushNamedAndRemoveUntil(
                //     context, "/home", (route) => false);

                Navigator.pushAndRemoveUntil<dynamic>(context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) =>Home(),
                  ),
                      (route) =>false,
                );
              },
              icon: Icon(Icons.list_alt))
        ],
      ),
      body: getProduct(context),
    );
  }
}
